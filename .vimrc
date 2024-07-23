filetype plugin on
syntax on

set termguicolors
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

" Eslint format
set errorformat+=%A%f:%l:%c:%m,%-G%.%#

if executable('rg')
  set grepprg=rg\ --vimgrep
endif

let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/vim')

Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }

Plug 'Chandlercjy/vim-markdown-edit-code-block', { 'for':'markdown'}
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'cherryramatisdev/theme-sync.vim'
let g:theme_sync_light_colorscheme = 'catppuccin_latte'
let g:theme_sync_dark_colorscheme = 'catppuccin_mocha'
Plug 'vim-ruby/vim-ruby'
Plug 'elixir-editors/vim-elixir'
Plug 'joker1007/vim-ruby-heredoc-syntax'
let g:ruby_heredoc_syntax_filetypes = {
        \ "sql" : {
        \   "start" : "SQL",
        \},
  \}

Plug 'fatih/vim-go'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-emmet.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'

Plug 'SirVer/ultisnips'
Plug 'prabirshrestha/async.vim'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsSnippetDirectories = [expand('~/git/personal/stowed/snippets')]
let g:UltiSnipsJumpBackwardTrigger="<c-j>"

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'bogado/file-line'
Plug 'pbrisbin/vim-mkdir'

Plug 'preservim/vim-pencil'
Plug 'junegunn/goyo.vim'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
Plug 'jreybert/vimagit'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-surround'

Plug 'AndrewRadev/switch.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/sideways.vim'
nnoremap gh :SidewaysLeft<cr>
nnoremap gl :SidewaysRight<cr>
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

Plug 'AndrewRadev/qftools.vim'
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key = '<C-z>'
let g:user_emmet_expandabbr_key = '<C-x><C-e>'
Plug 'tpope/vim-dadbod'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

call plug#end()

let NERDTreeHijackNetrw = 0

let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
augroup END

let g:lsp_completion_documentation_enabled = 0
let g:lsp_document_highlight_enabled = 0
let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_signature_help_enabled = 0

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> ga <plug>(lsp-code-action)
  vmap <buffer> ga <cmd>LspCodeAction<cr>
  nmap <buffer> rn <plug>(lsp-rename)
  nmap <buffer> [d <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]d <plug>(lsp-next-diagnostic)
  nmap <buffer> gq <plug>(lsp-document-diagnostics)
  nmap <buffer> K <plug>(lsp-hover)
  nmap <buffer> <leader>f <cmd>LspDocumentFormat<cr>
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'completor': function('asyncomplete#sources#buffer#completor')
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#emmet#get_source_options({
    \ 'name': 'emmet',
    \ 'whitelist': ['html', 'typescriptreact'],
    \ 'completor': function('asyncomplete#sources#emmet#completor'),
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'allowlist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))

inoremap <c-o> <c-x><c-o>
nnoremap <c-f> <cmd>FZF<cr>
nnoremap <c-s> <cmd>Rg<cr>

autocmd FileType markdown nmap <buffer> <silent> <space>e :MarkdownEditBlock<CR>
autocmd FileType fugitive nmap <buffer> cc cvc

nnoremap <space><space> <cmd>NERDTreeToggle<cr>
nnoremap <space>f <cmd>NERDTreeFind<cr>
