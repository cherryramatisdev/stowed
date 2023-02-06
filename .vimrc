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
if has('nvim')
  Plug 'nvim-lua/plenary.nvim'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'nvim-treesitter/nvim-treesitter'
else
  Plug 'dense-analysis/ale'
end
Plug 'justinmk/vim-dirvish'

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

" Tpope
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
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

set splitright splitbelow

" Show line numbers
set number
set relativenumber

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

if has('gui')
  colorscheme default
  set guifont=JetBrainsMono\ Nerd\ Font:h22
  let $FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
endif

if has('nvim')
  set guicursor=
endif

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set t_Co=256
set background=dark

hi Pmenu ctermbg=black ctermfg=white

autocmd CompleteDone * pclose

inoremap <C-o> <C-x><C-o>
inoremap <C-f> <C-x><C-f>

nnoremap <Tab> :tabn<cr>
nnoremap <S-Tab> :tabp<cr>

if has('nvim')
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "tsx", "lua", "vim", "help", "typescript", "elixir", "html" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
endif

if has('nvim')
lua << EOF
    local null_ls = require("null-ls")

    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = {'*.ts', '*.tsx', '*.ex', '*.exs', '*.heex', '*.rb'},
      callback = function()
        null_ls.setup({
            sources = {
                null_ls.builtins.diagnostics.eslint,
                null_ls.builtins.formatting.eslint,
                null_ls.builtins.diagnostics.rubocop,
                null_ls.builtins.formatting.rubocop,
                null_ls.builtins.diagnostics.credo,
                null_ls.builtins.formatting.mix
            },
        })
      end
    })

    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = {'*.ts', '*.tsx'},
      callback = function()
        vim.lsp.start({
          name = 'typescript-language-server',
          cmd = {'typescript-language-server', '--stdio'},
          root_dir = vim.fs.dirname(vim.fs.find({'package.json'}, { upward = true })[1]),
        })
      end,
    })

    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = {'*.rb'},
      callback = function()
        vim.lsp.start({
          name = 'solargraph',
          cmd = {'bundle', 'exec', 'solargraph', 'stdio'},
          root_dir = vim.fs.dirname(vim.fs.find({'Gemfile'}, { upward = true })[1]),
        })
      end,
    })

    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = {'*.ex', '*.exs', '*.heex'},
      callback = function()
        vim.lsp.start({
          name = 'elixir-ls',
          cmd = {vim.fn.expand('~/Packages/elixir-ls/rel/language_server.sh')},
          root_dir = vim.fs.dirname(vim.fs.find({'mix.exs'}, { upward = true })[1]),
        })
      end,
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.bo[args.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
        vim.keymap.set('n', '<C-^>', vim.lsp.buf.references, { buffer = args.buf })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = args.buf })
        vim.keymap.set('n', 'go', vim.diagnostic.setloclist, { buffer = args.buf })
        vim.keymap.set('n', 'rn', vim.lsp.buf.rename, { buffer = args.buf })
        vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { buffer = args.buf })
        vim.keymap.set('x', 'ga', vim.lsp.buf.code_action, { buffer = args.buf })
        vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = args.buf })
        end,
    })
EOF
endif

if !has('nvim')
  " ALE CONFIGURATION
  let g:ale_linters = {
        \ 'typescript': ['tsserver', 'eslint'],
        \ 'typescriptreact': ['tsserver', 'eslint'],
        \ 'elixir': ['elixir-ls'],
        \ 'ruby': ['solargraph'],
        \ }

  let g:ale_elixir_elixir_ls_release = expand("/Users/cherryramatis/Packages/elixir-ls/rel")
  let g:ale_elixir_elixir_ls_config = {'elixirLS': {'dialyzerEnabled': v:false}}

  let g:ale_fixers = {
        \ '*': ['remove_trailing_lines', 'trim_whitespace'],
        \ 'typescript': ['eslint'],
        \ 'typescriptreact': ['eslint'],
        \ 'elixir': ['mix_format'],
        \ 'ruby': ['rubocop'],
        \ }

  let g:ale_fix_on_save = 1
  set signcolumn=yes
  let g:ale_sign_column_always = 1


  function! s:setInsideAle(cmd) abort
    let l:fts = g:ale_linters->keys()

    execute 'autocmd FileType ' . l:fts->join(',') . ' ' . a:cmd
  endfunction

  augroup ALE
    autocmd!
    " TODO: for some reason this need to be done to work with ruby
    " nmap <C-]> <cmd>ALEGoToDefinition<cr>
    call s:setInsideAle('set omnifunc=ale#completion#OmniFunc')
    call s:setInsideAle('nmap <C-]> <cmd>ALEGoToDefinition<cr>')
    call s:setInsideAle('nnoremap <C-^> <cmd>ALEFindReferences<cr>')
    call s:setInsideAle('nnoremap gi <cmd>ALEGoToImplementation<cr>')
    call s:setInsideAle('nnoremap go <cmd>ALEPopulateLocList<cr>')
    call s:setInsideAle('nnoremap rn <cmd>ALERename<cr>')
    call s:setInsideAle('nnoremap rN <cmd>ALEFileRename<cr>')
    call s:setInsideAle('nnoremap K <cmd>ALEHover<cr>')
    call s:setInsideAle('nnoremap ga <cmd>ALECodeAction<cr>')
    call s:setInsideAle('xnoremap ga <cmd>ALECodeAction<cr>')
  augroup END
endif
