if !has('python') && !has('python3')
  echo "Error: Required vim compiled with +python or +python3"
  finish
endif

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/buffering.py'

function! BufferingOpen()
  if has('python')
    :py buffers = get_open_buffers()
    :py open_buffering(buffers)
  else
    :py3 buffers = get_open_buffers()
    :py3 open_buffering(buffers)
  endif
endfunction

function! BufferingDeleteBuffer()
  if has('python')
    :py delete_buffer()
    :py vim.command("call RefreshBuffering()")
  else
    :py3 delete_buffer()
    :py3 vim.command("call RefreshBuffering()")
  endif
endfunction

function! BufferingDeleteAllBuffers()
  if has('python')
    :py delete_all_buffers()
    :py print "All buffers deleted"
  else
    :py3 delete_all_buffers()
    :py3 print "All buffers deleted"
  endif
endfunction


function! RefreshBuffering()
  if has('python')
    :py refresh_buffering()
  else
    :py3 refresh_buffering()
  endif
endfunction

function! BufferingOpenBuffer()
  if has('python')
    :py open_buffer()
  else
    :py3 open_buffer()
  endif
endfunction

":::::::::::::::::::::::::::::::::::::::::::::::
"::::::::::::: Init all python stuff :::::::::::
":::::::::::::::::::::::::::::::::::::::::::::::
function! DefPython()
if has('python')
  exec 'pyfile ' . s:path
else
  exec 'py3file ' . s:path
endif
endfunction
"::::::::::::::::::::::::::::::::::::::::::::::::::::::
"::::::::::::::: END OF: Init all python stuff ::::::::
"::::::::::::::::::::::::::::::::::::::::::::::::::::::

call DefPython()
