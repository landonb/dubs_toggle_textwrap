" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/dubs_toggle_textwrap
" License: GPLv3
" Summary: Dubs Vim ToggleWrap

" -------------------------------------------------------------------

" ABOUT:
"
" For notes and usage, try :help dubs-toggle-textwrap.
"
"   tl;dr, use \w to smartly toggle wrapping.

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:plugin_dubs_toggle_textwrap
endif

if exists('g:plugin_dubs_toggle_textwrap') || &cp

  finish
endif

let g:plugin_dubs_toggle_textwrap = 1

" -------------------------------------------------------------------

" ToggleWrap function
" -------------------------
" The two functions called by ToogleWrap toggle the wrap
" options on or off. They take care of adjusting the
" environment to be more functional in either mode (at
" least more functional per the author's preferences).
"
" CXREF:
" ~/.vim/pack/landonb/start/dubs_toggle_textwrap/autoload/toggle_textwrap/wrapnav.vim
function s:ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    call g:toggle_textwrap#wrapnav#DisableWrapNav()
  else
    echo "Wrap ON"
    call g:toggle_textwrap#wrapnav#EnableWrapNav()
  endif
endfunction

" Toggle wrapping with \w
" -------------------------
" CALSO/2020-05-10: vim-surround also toggles wrap: `[ow`, `]ow`, and `yow`.
" - HSTRY/2024-12-10: Was <Leader>w, but I've coalesced Dubs Vim maps under \d.
noremap <silent> <Leader>dw :call <SID>ToggleWrap()<CR>


" Adjust environment on Vim startup
" -------------------------
" The following runs when Vim sources this file (i.e.,
" when Vim is starting), so adjust the environment
" depending on the &wrap state.
if &wrap
  call g:toggle_textwrap#wrapnav#EnableWrapNav()
else
  call g:toggle_textwrap#wrapnav#DisableWrapNav()
endif

" HSTRY/2024-12-03: This plugin used to restrict the maps
" to each buffer, e.g.,
"
"   function g:toggle_textwrap#wrapnav#EnableWrapNav()
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
"     \   call g:toggle_textwrap#wrapnav#EnableWrapNav() |
"     \ endif

" ------------------------------------------
" ----------------------------------- EOF --

