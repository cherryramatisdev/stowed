filetype plugin on
syntax on

set mouse=a
set hidden
set nu rnu
set tw=80
set tabstop=2
set shiftwidth=2
set autoindent
set expandtab
set noswapfile
set completeopt=menu,menuone,noinsert
set shortmess+=c
set belloff+=ctrlg
set splitright splitbelow
set laststatus=0

" Eslint format
set errorformat+=%A%f:%l:%c:%m,%-G%.%#

if executable('rg')
  set grepprg=rg\ --vimgrep
endif

" let data_dir = '~/.vim'
" if empty(glob(data_dir . '/autoload/plug.vim'))
"   silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

" call plug#begin('~/.local/share/vim')

" Plug 'vim-ruby/vim-ruby'
" Plug 'neovimhaskell/haskell-vim'
" Plug 'elixir-editors/vim-elixir'
" Plug 'joker1007/vim-ruby-heredoc-syntax'
" let g:ruby_heredoc_syntax_filetypes = {
"         \ "sql" : {
"         \   "start" : "SQL",
"         \},
"   \}

" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

" Plug 'bogado/file-line'
" Plug 'pbrisbin/vim-mkdir'

" Plug 'tpope/vim-sensible'
" Plug 'tpope/vim-sleuth'
" Plug 'tpope/vim-endwise'
" Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-abolish'
" Plug 'tpope/vim-vinegar'
" Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-dispatch'
" Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
" Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-dadbod'
" Plug 'tpope/vim-surround'

" Plug 'AndrewRadev/sideways.vim'
" nnoremap gh :SidewaysLeft<cr>
" nnoremap gl :SidewaysRight<cr>
" omap aa <Plug>SidewaysArgumentTextobjA
" xmap aa <Plug>SidewaysArgumentTextobjA
" omap ia <Plug>SidewaysArgumentTextobjI
" xmap ia <Plug>SidewaysArgumentTextobjI

" Plug 'mattn/emmet-vim'
" let g:user_emmet_leader_key = '<C-z>'
" let g:user_emmet_expandabbr_key = '<C-x><C-e>'

" Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" call plug#end()

set background=dark
colorscheme quiet

inoremap <c-o> <c-x><c-o>
nnoremap <c-f> <cmd>FZF<cr>
nnoremap <c-s> <cmd>Rg<cr>

autocmd FileType markdown nmap <buffer> <silent> <leader>e :MarkdownEditBlock<CR>
autocmd FileType fugitive nmap <buffer> cc cvc

nnoremap <space>e <cmd>NERDTreeToggle<cr>
nnoremap <space>f <cmd>NERDTreeFind<cr>

autocmd BufRead *.html setlocal filetype=html.angular
