" Taken from https://gist.github.com/ram535/b1b7af6cd7769ec0481eb2eed549ea23
" With this function you can reuse the same terminal in neovim.
" You can toggle the terminal and also send a command to the same terminal.

let s:rnr_window = -1
let s:rnr_buffer = -1
let s:rnr_job_id = -1

function! RnrOpen()
  " Check if buffer exists, if not create a window and a buffer
  if !bufexists(s:rnr_buffer)
    " Creates a window call rnr_terminal
    new rnr_terminal
    " Moves to the window the right the current one
    wincmd L
    let s:rnr_job_id = termopen($SHELL, { 'detach': 1 })

     " Change the name of the buffer to "Terminal 1"
     silent file Terminal\ 1
     " Gets the id of the terminal window
     let s:rnr_window = win_getid()
     let s:rnr_buffer = bufnr('%')

    " The buffer of the terminal won't appear in the list of the buffers
    " when calling :buffers command
    set nobuflisted
  else
    if !win_gotoid(s:rnr_window)
    sp
    " Moves to the window below the current one
    wincmd L
    buffer Terminal\ 1
     " Gets the id of the terminal window
     let s:rnr_window = win_getid()
    endif
  endif
endfunction

function! RnrToggle()
  if win_gotoid(s:rnr_window)
    call RnrClose()
  else
    call RnrOpen()
    startinsert
  endif
endfunction

function! RnrClose()
  if win_gotoid(s:rnr_window)
    " close the current window
    hide
  endif
endfunction

function! RnrExec(cmd)
  if !win_gotoid(s:rnr_window)
    call RnrOpen()
  endif

  " clear current input
  call jobsend(s:rnr_job_id, "clear\n")

  " run cmd
  call jobsend(s:rnr_job_id, a:cmd . "\n")
  normal! G
  wincmd p
endfunction

" With this maps you can now toggle the terminal
nnoremap <leader>t :call RnrToggle()<cr>
tnoremap <leader>t <C-\><C-n>:call RnrToggle()<cr>
nnoremap <F7> :call RnrToggle()<cr>
tnoremap <F7> <C-\><C-n>:call RnrToggle()<cr>

" This an example on how specify command with different types of files.
    augroup rust
        autocmd!
        autocmd BufRead,BufNewFile *.rust set filetype=rust
        autocmd FileType rust nnoremap <leader>ct :call RnrExec('cargo test')<cr>
    augroup END
