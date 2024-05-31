filetype plugin on
syntax on

set tabstop=2
set shiftwidth=2
set expandtab
set noswapfile
set completeopt=menu,noinsert

let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/vim')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'dense-analysis/ale'
Plug 'vim-scripts/AutoComplPop'
Plug 'bogado/file-line'
Plug 'pbrisbin/vim-mkdir'
call plug#end()

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\}

let g:ale_linters = {
\   'javascript': ['eslint', 'tsserver'],
\   'javascriptreact': ['eslint', 'tsserver'],
\   'typescript': ['eslint', 'tsserver'],
\   'typescriptreact': ['eslint', 'tsserver'],
\}

let g:ale_fix_on_save = 1
set omnifunc=ale#completion#OmniFunc
nnoremap <c-]> :ALEGoToDefinition<cr>
nnoremap <c-w>] <c-w>v:ALEGoToDefinition<cr>
nnoremap K :ALEHover<cr>
nnoremap ga :ALECodeAction<cr>

fun! FindReferences() abort
  ALEFindReferences -quickfix
  copen
endfun

nnoremap gr :call FindReferences()<cr>
nnoremap gi :ALEGoToImplementation<cr>
inoremap <c-o> <c-x><c-o>
