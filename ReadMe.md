## Buffering

A simple plugin to manage buffers (open and hidden)

### Proposed key binding - add them to your ~/.vimrc
`nnoremap <silent> <leader>b :call BufferingOpen()<CR>` - opens a window listing buffers
`nnoremap <silent> <leader>bo :call BufferingOpenBuffer()<CR>` - either fill the above window with the selected buffer or activate window that already has the buffer open
`nnoremap <silent> <leader>bd :call BufferingDeleteBuffer()<CR>` - permanently remove a selected buffer from the above window
`nnoremap <silent> <leader>bdd :call BufferingDeleteAllBuffers()<CR>` - permanently remove all the buffers - __Note__: Any unsaved changes will be lost


### Todo:
- doc
