" Modes
nnoremap <Space>x <Esc>
xnoremap v <Esc>`>
xnoremap V <Esc>`<
inoremap jk <Esc>
nnoremap <Space>o o<Esc>
nnoremap <Space>O O<Esc>
nnoremap L :vsc View.NavigateForward<CR>
nnoremap H :vsc View.NavigateBackward<CR>

" Navigate Windows
nnoremap <Space>wh :vsc Window.PreviousPane<CR>
nnoremap <Space>wl :vsc Window.NextPane<CR>
nnoremap <Space>wk :vsc Window.PreviousPane<CR>
nnoremap <Space>wj :vsc Window.NextPane<CR>
nnoremap <Space>ws :vsc Window.SplitWindowVertically<CR>
nnoremap <Space>ww :vsc File.SaveAll<CR>
nnoremap <Space>wq :vsc Window.Close<CR>

" Navigate Tabs
nnoremap <Space>th :vsc Window.PreviousTab<CR>
nnoremap <Space>tl :vsc Window.NextTab<CR>
nnoremap <Space>ts :vsc Window:MovetoNextTabGroup<CR>

" Search
nnoremap <Space>ss /

" File
nnoremap <Space>fp :vsc Edit.FormatDocument<CR>

" Code
nnoremap <Space>ca :vsc View.QuickActionsForPosition<CR>
nnoremap <Space>cr :vsc Refactor.Rename<CR>
nnoremap <Space>cc :vsc Edit.ToggleLineComment<CR>

" Diagnostics
nnoremap ]d :vsc View.NextError<CR>
nnoremap [d :vsc View.PreviousError<CR>
nnoremap <Space>ld :vsc View.ErrorList<CR>

" Lsp
nnoremap <Space>gd :vsc Edit.GoToDefinition<CR>
nnoremap <Space>gi :vsc Edit.GoToImplementation<CR>
nnoremap <Space>gr :vsc Edit.FindAllReferences<CR>
