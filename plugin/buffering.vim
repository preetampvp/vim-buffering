if !has('python') && !has('python3')
  echo "Error: Required vim compiled with +python or +python3"
  finish
endif

if has('python')
  let g:_vbpy=":python"
endif

if has('python3')
  let g:_vbpy=":python3"
endif

function! BufferingOpen()
g:_vbpy << EOF
buffers = get_open_buffers()
open_buffering(buffers)
EOF
endfunction

function! BufferingDeleteBuffer()
g:_vbpy << EOF
delete_buffer()
vim.command("call RefreshBuffering()")
EOF
endfunction

function! BufferingDeleteAllBuffers()
g:_vbpy << EOF
delete_all_buffers()
print "All buffers deleted"
EOF
endfunction


function! RefreshBuffering()
g:_vbpy << EOF
refresh_buffering()
EOF
endfunction

function! BufferingOpenBuffer()
g:_vbpy << EOF
open_buffer()
EOF
endfunction

":::::::::::::::::::::::::::::::::::::::::::::::
"::::::::::::: Init all python stuff :::::::::::
":::::::::::::::::::::::::::::::::::::::::::::::
function! DefPython()
g:_vbpy << EOF

import sys
import vim
sys.path.append(vim.eval('expand("<sfile>:h")'))

def open_buffering(buffer_names):
    vim.command('rightbelow split {0}'.format('buffering'))
    vim.command('normal! ggdG')
    vim.command('setlocal buftype=nowrite')
    vim.command('call append(0, {0})'.format(buffer_names))
    vim.command('normal! gg')

def get_open_buffers():
    buffers = vim.buffers
    valid_open_buffers = [buffer for buffer in buffers]
    buffer_names = []
    for buffer in valid_open_buffers:
      buffer_name = vim.eval('bufname("{}")'.format(buffer.name))
      buffer_listed = vim.eval('buflisted("{}")'.format(buffer.name))
      if buffer_listed == "1" and buffer_name != "buffering":
        buffer_names.append('{0}'.format(buffer_name))

    return buffer_names

def delete_buffer():
  if vim.eval('bufname("{}")'.format(vim.current.buffer.name)) != "buffering":
    return

  buffer_name_to_delete = vim.current.line
  if buffer_name_to_delete != '':
    vim.command('bd {}'.format(buffer_name_to_delete))
    print 'Deleted: {}'.format(buffer_name_to_delete)

def delete_all_buffers():
  if vim.eval('bufname("{}")'.format(vim.current.buffer.name)) != "buffering":
    return

  buffers = get_open_buffers()
  for buffer in buffers:
    vim.command('bd! {}'.format(buffer))

  vim.command('bd %')

def refresh_buffering():
  if vim.eval('bufname("{}")'.format(vim.current.buffer.name)) != "buffering":
    return

  buffer_names = get_open_buffers()
  vim.command('normal! ggdG')
  vim.command('call append(0, {0})'.format(buffer_names))

def open_buffer():
  if vim.eval('bufname("{}")'.format(vim.current.buffer.name)) != "buffering":
    return

  buffer_to_open = vim.current.line
  for window in vim.windows:
    window_buffer_name = vim.eval('bufname("{}")'.format(window.buffer.name))
    if window_buffer_name == buffer_to_open:
      window_buffer_number = vim.eval('bufnr("{}")'.format(window.buffer.name))
      windows_with_that_buffer = vim.eval('win_findbuf({})'.format(window_buffer_number))
      first_match_window = windows_with_that_buffer[0]


      vim.command('bd %')
      vim.eval('win_gotoid({})'.format(first_match_window))
      return

  vim.command('b {}'.format(buffer_to_open))

EOF

endfunction
"::::::::::::::::::::::::::::::::::::::::::::::::::::::
"::::::::::::::: END OF: Init all python stuff ::::::::
"::::::::::::::::::::::::::::::::::::::::::::::::::::::

call DefPython()
