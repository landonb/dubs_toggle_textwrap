" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/dubs_toggle_textwrap
" License: GPLv3
" Summary: Dubs Vim ToggleWrap
" -------------------------------------------------------------------

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
" CALSO/2020-05-10: vim-surround also toggles wrap: `[ow`, `]ow`, and `yow`.
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
  " NOTE Not sure we should be setting
  "      virtualedit=all in UnwrapIt()
  "  set virtualedit=
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
  nnoremap <silent> k gk
  nnoremap <silent> j gj
  nnoremap <silent> <Up>   gk
  nnoremap <silent> <Down> gj
  nnoremap <silent> <Home> g<Home>
  nnoremap <silent> <End>  g<End>
  inoremap <silent> <Up>   <C-o>gk
  inoremap <silent> <Down> <C-o>gj
  inoremap <silent> <Home> <C-o>g<Home>
  inoremap <silent> <End>  <C-o>g<End>
  snoremap <silent> <Up>   <C-o><Esc>gk
  snoremap <silent> <Down> <C-o><Esc>gj
  snoremap <silent> <Home> <C-o><Esc>g<Home>
  snoremap <silent> <End>  <C-o><Esc>g<End>
endfunction

" UnwrapIt
" -------------------------
" Undoes (resets back to normal)
" everything WrapIt() changed
function s:UnwrapIt()
  set nowrap
  " Setting virtualedit=all allows you
  " to move the cursor past the end of
  " a logical line of text (or even over
  " the individual visual space characters
  " used to represent a logical <Tab>). If
  " you insert, Vim just pads from the end
  " of the logical line to the cursor with
  " spaces.
  "   To really see the end of a logical line,
  " rather than using <Right>, hit <End>.
  " MAYBE/2015-01-26: &virtualedit is interesting,
  " but is it helpful?
  "  set virtualedit=all
  nnoremap <silent> k k
  nnoremap <silent> j j
  nnoremap <silent> <Up>   k
  nnoremap <silent> <Down> j
  nnoremap <silent> <Home> <Home>
  nnoremap <silent> <End>  <End>
  inoremap <silent> <Up>   <C-o>k
  inoremap <silent> <Down> <C-o>j
  inoremap <silent> <Home> <C-o><Home>
  inoremap <silent> <End>  <C-o><End>
  snoremap <silent> <Up>   <C-o>k
  snoremap <silent> <Down> <C-o>j
  snoremap <silent> <Home> <C-o><Home>
  snoremap <silent> <End>  <C-o><End>
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

" HSTRY/2024-12-03: This plugin used to restrict the maps
" to each buffer, e.g.,
"
"   function s:WrapIt()
"     ...
"     nnoremap <buffer> <silent> k gk
"     nnoremap <buffer> <silent> j gj
"     ...
"
" But that doesn't seem to matter (i.e., when whether
" &wrap or &nowrap).
" - Also we need to place nice with coc.nvim, which defines
"   <Up> and <Down> maps to work with the suggestion popup
"   menu.
"
" So the <buffer> limitations have been removed, along with
" the autocommand that ran to ensure the new buffers were
" wired correctly too:
"
"   " Don't forget new buffers!
"   " -------------------------
"   autocmd BufWinEnter *
"     \ if &wrap |
"     \   call <SID>WrapIt() |
"     \ endif

" ------------------------------------------
" ----------------------------------- EOF --

