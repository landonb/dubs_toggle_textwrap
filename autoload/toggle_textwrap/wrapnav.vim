" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/dubs_toggle_textwrap
" License: GPLv3
" Summary: Dubs Vim ToggleWrap

function! g:toggle_textwrap#wrapnav#EnableWrapNav()
  " Turn on wrapping (whereby lines are
  " wrapped as soon as they hit the right
  " edge of the window)
  set wrap
  " Tell wrapping to logically wrap at word
  " boundaries, so they're easier to read
  set linebreak
  " Disable virtualedit, which ...
  " NOTE Not sure we should be setting virtualedit=all
  "      in g:toggle_textwrap#wrapnav#DisableWrapNav()
  "  set virtualedit=
  " Set the characters the linebreak option
  " uses to determine where to break the line.
  " NOTE This is breakat's default setting
  "      ... so I'm not sure setting this is
  "      really all that necessary...
  "      unless maybe another call in
  "      g:toggle_textwrap#wrapnav#DisableWrapNav()
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

" Undoes (resets back to normal) everything changed
" by g:toggle_textwrap#wrapnav#EnableWrapNav()
function! g:toggle_textwrap#wrapnav#DisableWrapNav()
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

