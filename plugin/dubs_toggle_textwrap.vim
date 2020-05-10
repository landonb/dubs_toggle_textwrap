" File: dubs_toggle_textwrap.vim
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Last Modified: 2015.01.27
" Project Page: https://github.com/landonb/dubs_toggle_textwrap
" Summary: Dubs Vim ToggleWrap
" License: GPLv3
" -------------------------------------------------------------------
" Copyright © 2009, 2015 Landon Bouma.
" 
" This file is part of Dubs Vim.
" 
" Dubs Vim is free software: you can redistribute it and/or
" modify it under the terms of the GNU General Public License
" as published by the Free Software Foundation, either version
" 3 of the License, or (at your option) any later version.
" 
" Dubs Vim is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty
" of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
" the GNU General Public License for more details.
" 
" You should have received a copy of the GNU General Public License
" along with Dubs Vim. If not, see <http://www.gnu.org/licenses/>
" or write Free Software Foundation, Inc., 51 Franklin Street,
"                     Fifth Floor, Boston, MA 02110-1301, USA.
" ===================================================================

" ------------------------------------------
" About:

" For notes and usage, try :help dubs-toggle-textwrap.
"
"   tl;dr, use \w to smartly toggle wrapping.

" Poo-poo on the double-load
if exists("g:plugin_dubs_toggle_textwrap") || &cp
  finish
endif
let g:plugin_dubs_toggle_textwrap = 1

" ToggleWrap function
" -------------------------
" ToggleWrap toggles the wrap options on or 
" off. The WrapIt() and UnwrapIt() functions 
" take care of massaging the environment to 
" be more functional in either mode.
function s:ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    call s:UnwrapIt()
  else
    echo "Wrap ON"
    call s:WrapIt()
  endif
endfunction

" Toggle wrapping with \w
" -------------------------
" SEE_ALSO/2020-05-10: vim-surround also toggles wrap: `[ow`, `]ow`, and `yow`.
noremap <silent> <Leader>w :call <SID>ToggleWrap()<CR>

" WrapIt
" -------------------------
function s:WrapIt()
  " Turn on wrapping (whereby lines are 
  " wrapped as soon as they hit the right
  " edge of the window)
  set wrap
  " Tell wrapping to logically wrap at word 
  " boundaries, so they're easier to read
  set linebreak
  " Disable virtualedit, which ...
  " TODO Not sure we should be setting 
  "      virtualedit=all in UnwrapIt()
  "set virtualedit=
  " Set the characters the linebreak option 
  " uses to determine where to break the line.
  " NOTE This is breakat's default setting 
  "      ... so I'm not sure setting this is 
  "      really all that necessary...
  "      unless maybe another call in UnwrapIt() 
  "      affects breakat?
  "set breakat=\ ^I!@*-+;:,./?
  " Add a '>' character to the start of every 
  " wrapped line
  " NOTE This sounds nice, but -- regardless that 
  "      I can't get it to work on Windows -- all 
  "      you really need is line numbers.
  "set showbreak=>
  " display defaults to ""; adding lastline means:
  "   "When included, as much as possible of the 
  "    last line in a window will be displayed.  
  "    When not included, last line that doesn't 
  "    fit is replaced with "@" lines."
  "  In other words, don't just show a bunch of 
  "  empty visual lines because Vim can't fit the 
  "  whole logical line in view!
  setlocal display+=lastline
  " Finally, remap navigation keys so they 
  " traverse visual boundaries, not logical ones 
  " (make sure to use <buffer> so it only applies 
  " to the current buffer).
  nnoremap  <buffer> <silent> k gk
  nnoremap  <buffer> <silent> j gj
  nnoremap  <buffer> <silent> <Up>   gk
  nnoremap  <buffer> <silent> <Down> gj
  nnoremap  <buffer> <silent> <Home> g<Home>
  nnoremap  <buffer> <silent> <End>  g<End>
  inoremap <buffer> <silent> <Up>   <C-o>gk
  inoremap <buffer> <silent> <Down> <C-o>gj
  inoremap <buffer> <silent> <Home> <C-o>g<Home>
  inoremap <buffer> <silent> <End>  <C-o>g<End>
  snoremap <buffer> <silent> <Up>   <C-o><Esc>gk
  snoremap <buffer> <silent> <Down> <C-o><Esc>gj
  snoremap <buffer> <silent> <Home> 
            \ <C-o><Esc>g<Home>
  snoremap <buffer> <silent> <End>  
            \ <C-o><Esc>g<End>
endfunction
 
" UnwrapIt
" -------------------------
" Undoes (resets back to normal) 
" everything WrapIt() changed
function s:UnwrapIt()
  set nowrap
  "   Setting virtualedit=all allows you 
  " to move the cursor past the end of 
  " a logical line of text (or even over 
  " the individual visual space characters 
  " used to represent a logical <Tab>). If 
  " you insert, Vim just pads from the end 
  " of the logical line to the cursor with 
  " spaces.
  "   To really see the end of a logical line, 
  " rather than using <Right>, hit <End>.
  " TODO This is interesting, but is it helpful?
  "set virtualedit=all
  nnoremap  <buffer> <silent> k k
  nnoremap  <buffer> <silent> j j
  nnoremap  <buffer> <silent> <Up>   k
  nnoremap  <buffer> <silent> <Down> j
  nnoremap  <buffer> <silent> <Home> <Home>
  nnoremap  <buffer> <silent> <End>  <End>
  inoremap <buffer> <silent> <Up>   <C-o>k
  inoremap <buffer> <silent> <Down> <C-o>j
  inoremap <buffer> <silent> <Home> <C-o><Home>
  inoremap <buffer> <silent> <End>  <C-o><End>
  snoremap <buffer> <silent> <Up>   <C-o>k
  snoremap <buffer> <silent> <Down> <C-o>j
  snoremap <buffer> <silent> <Home> <C-o><Home>
  snoremap <buffer> <silent> <End>  <C-o><End>
endfunction

" Fix environment on Vim startup
" -------------------------
" The following runs when Vim sources 
" this file (probably when Vim is 
" starting), so we should fix the 
" environment here if we set to wrap.
if &wrap
  call s:WrapIt()
endif

" Don't forget new buffers!
" -------------------------
autocmd BufWinEnter *
  \ if &wrap |
  \   call <SID>WrapIt() |
  \ endif

" ------------------------------------------
" ----------------------------------- EOF --

