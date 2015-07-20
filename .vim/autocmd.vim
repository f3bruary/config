" AUTOCOMMANDS
if has("autocmd")
  augroup filetypedetect
    au BufEnter *.markdown,*.mkd,*.md setl wrap tw=79
    au BufEnter *.json setl ft=javascript
    au BufEnter *.coffee setl sw=2 expandtab
    au BufEnter *.py setl ts=4 sw=4 sts=4
    au BufEnter *.php setl ts=4 sw=4 sts=4
    au BufEnter *.js setl ts=2 sw=2 sts=2
    au BufEnter *.html setl ts=4 sw=4 sts=4
    au BufEnter *.tex setl wrap tw=79 fo=tcqor
    au BufEnter *.[ch] setl cindent
    au BufEnter *.[ch]pp setl cindent
    au BufEnter Makefile setl ts=4 sts=4 sw=4 noet list
  augroup END

  " when enabling diff for a buffer it should be disabled when the
  " buffer is not visible anymore
  au BufHidden * if &diff == 1 | diffoff | setlocal nowrap | endif

  " Instead of reverting the cursor to the last position in the buffer, we
  " set it to the first line when editing a git commit message
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

  " Automatically removing all trailing whitespace
  autocmd BufWritePre * :call StripTrailingWhitespace()

  " Save on FocusLost
  au FocusLost * :silent! wall " Save on FocusLost
  au FocusLost * call feedkeys("\<C-\>\<C-n>") " Return to normal mode on FocustLost

  " Disable paste mode when leaving Insert Mode
  au InsertLeave * set nopaste

  " Resize splits when the window is resized
  au VimResized * exe "normal! \<c-w>="

  " preceding line best in a plugin but here for now.
  au BufNewFile,BufRead *.coffee set filetype=coffee

  " Workaround vim-commentary for Haskell
  au FileType haskell setlocal commentstring=--\ %s
  " Workaround broken colour highlighting in Haskell
  au FileType haskell setlocal nospell

  " Stupid shift key fixes
  if has("user_commands")
      command! -bang -nargs=* -complete=file E e<bang> <args>
      command! -bang -nargs=* -complete=file W w<bang> <args>
      command! -bang -nargs=* -complete=file Wq wq<bang> <args>
      command! -bang -nargs=* -complete=file WQ wq<bang> <args>
      command! -bang Wa wa<bang>
      command! -bang WA wa<bang>
      command! -bang Q q<bang>
      command! -bang QA qa<bang>
      command! -bang Qa qa<bang>
  endif
endif
