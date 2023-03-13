" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Plugins here
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'morhetz/gruvbox'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax
if !has('nvim')
  Plug 'elixir-editors/vim-elixir'
endif
Plug 'vim-ruby/vim-ruby'

Plug 'editorconfig/editorconfig-vim'

" Fuzzy
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let $FZF_DEFAULT_OPTS='--layout=reverse'
nnoremap <C-p> :FZF<cr>
nnoremap <C-s> :Rg<cr>

Plug 'lambdalisue/fern.vim'

" Tpope
Plug 'LnL7/vim-nix'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary' | Plug 'suy/vim-context-commentstring'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'

" Andrew radev
Plug 'AndrewRadev/splitjoin.vim'
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
nnoremap gk :SplitjoinJoin<cr>
nnoremap gj :SplitjoinSplit<cr>
Plug 'AndrewRadev/switch.vim'
Plug 'AndrewRadev/sideways.vim'
nnoremap <C-h> :SidewaysLeft<cr>
nnoremap <C-l> :SidewaysRight<cr>
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI
Plug 'AndrewRadev/tagalong.vim'
call plug#end()

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

let mapleader = " "

" Security
set modelines=0

set re=2

set splitright splitbelow

" Show line numbers
set number
set relativenumber

set noswapfile

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
" set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

if v:version >= 800
  " stop vim from silently messing with files that it shouldn't
  set nofixendofline

  " better ascii friendly listchars
  set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>

  " i hate automatic folding
  set foldmethod=manual
  set nofoldenable
endif

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set nohlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

set wildmenu
set wildoptions=pum

colorscheme gruvbox

if has('nvim')
  set guicursor=
endif

if has('nvim')
  fun! s:PopTerm(direction) abort
    let l:cmds = {"split": "7sp", "tab": "tabnew"}
    execute l:cmds[a:direction] . ' | term'
  endfun
  nnoremap <leader>ot :call <SID>PopTerm("split")<cr>
  nnoremap <leader>oT :call <SID>PopTerm("tab")<cr>
else
  nnoremap <leader>ot :term<cr>
  nnoremap <leader>oT :tab term<cr>
endif

nnoremap <expr> cn &filetype ==#'fugitive' ? ":Git commit -v --no-verify<cr>" : "cn"
nnoremap <expr> gb &filetype ==#'fugitive' ? ":silent ! gh pr view -w<cr>" : "gb"

nnoremap <expr> <cr> &buftype==#'terminal' ? "\<C-w>gF" : '\<cr>'

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

if has('nvim')
  tnoremap <c-space> <C-\><C-n>
else
  tnoremap <c-@> <C-\><C-n>
endif

" Color scheme (terminal)
set t_Co=256
set background=dark
colorscheme gruvbox

hi Pmenu ctermbg=black ctermfg=white

autocmd CompleteDone * pclose

inoremap <C-o> <C-x><C-o>
inoremap <C-f> <C-x><C-f>

nnoremap <Tab> :tabn<cr>
nnoremap <S-Tab> :tabp<cr>

nmap Y y$

nnoremap <leader>y "+y
xnoremap <leader>y "+y
nnoremap <leader>Y "+Y
nnoremap <leader>p "+p

" ---- FERN ----

" Custom settings and mappings.
let g:fern#disable_default_mappings = 1

noremap <silent> <Leader>op :Fern . -drawer -toggle -width=35<CR><C-w>=
noremap <silent> <Leader>oP :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <cr> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> q <cmd>q<cr>
  nmap <buffer> o <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> M <Plug>(fern-action-move)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> z <Plug>(fern-action-hidden:toggle)
  nmap <buffer> <c-l> <Plug>(fern-action-reload)
  nmap <buffer> <Tab> <Plug>(fern-action-mark:toggle)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer><nowait> h <Plug>(fern-action-leave)
  nmap <buffer><nowait> l <Plug>(fern-action-enter)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

" ________________ COC.NVIM ________
let g:coc_global_extensions = ['coc-json',
      \ 'coc-git',
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-rust-analyzer',
      \ 'coc-cssmodules',
      \ 'coc-marketplace',
      \ ]
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-o> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" GoTo code navigation
set tagfunc=CocTagFunc
nmap <silent> gT <Plug>(coc-type-definition)
nmap <silent> gI <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)

function! s:eslint_or_format() abort
  let l:filetypes = ["typescript", "typescriptreact", "javascript", "javascriptreact"]
  if index(l:filetypes, &filetype) >= 0
    execute "CocCommand eslint.executeAutofix"
  else
    execute "call CocActionAsync('format')"
  endif
endfunction

nnoremap <expr> <silent> <leader>f <sid>eslint_or_format()

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap ga  <Plug>(coc-codeaction-selected)
nmap ga  <Plug>(coc-codeaction)

" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
  nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
  inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<C-d>"
  inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<C-u>"
  vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
  vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
endif

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline=%f
set statusline+=\ %{coc#status()}%{get(b:,'coc_current_function','')}
set statusline+=%=
set statusline+=%y

" Manipulate hunks
nnoremap <silent><nowait> <leader>hp :CocCommand git.chunkInfo<cr>
nnoremap <silent><nowait> <leader>hs :CocCommand git.chunkStage<cr>
nnoremap <silent><nowait> <leader>hS :Gwrite<cr>
nnoremap <silent><nowait> <leader>hu :CocCommand git.chunkUnstage<cr>
nnoremap <silent><nowait> <leader>hU :CocCommand git.chunkUndo<cr>
nnoremap <silent><nowait> <leader>hc :Git commit -v --no-verify<cr>
nnoremap <silent><nowait> <leader>ha :Git commit --amend -v --no-verify<cr>
nnoremap ]c <Plug>(coc-git-nextchunk)
nnoremap [c <Plug>(coc-git-prevchunk)

" Show all diagnostics
nnoremap <silent><nowait> <leader>q  :<C-u>CocDiagnostics<cr>
" Show commands
nnoremap <silent><nowait> <leader>oc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <leader>ds  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <leader>ws  :<C-u>CocList -I symbols<cr>
