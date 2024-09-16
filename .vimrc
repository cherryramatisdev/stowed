if has("eval")                               " vim-tiny lacks 'eval'
  let skip_defaults_vim = 1
endif

set nocompatible

"####################### Vi Compatible (~/.exrc) #######################

" automatically indent new lines
set autoindent " (alpine)

set completeopt+=popup

if has('nvim')
  set guicursor=
endif

set signcolumn=yes

" replace tabs with spaces automatically
set expandtab " (alpine)

" number of spaces to replace a tab with when expandtab
set tabstop=2 " (alpine)

" use case when searching
set noignorecase

" automatically write files when changing when multiple files open
set autowrite

" deactivate line numbers
set nonumber

set fillchars+=stl:-,stlnc:-

set laststatus=2
set statusline=%=\ %f\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%

" show command and insert mode
set showmode

"#######################################################################

" disable bell (also disable in .inputrc)
set noerrorbells
set vb t_vb=

set softtabstop=2

" mostly used with >> and <<
set shiftwidth=2

set smartindent

set smarttab

if v:version >= 800
  " stop vim from silently messing with files that it shouldn't
  set nofixendofline

  " better ascii friendly listchars
  set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>

  " i hate automatic folding
  set foldmethod=manual
  set nofoldenable
endif

if executable('rg')
  set grepprg=rg\ --vimgrep
endif

" mark trailing spaces as errors
match IncSearch '\s\+$'

" enough for line numbers + gutter within 80 standard
set textwidth=72
"set colorcolumn=73

" disable relative line numbers, remove no to sample it
set norelativenumber

" makes ~ effectively invisible
"highlight NonText guifg=bg

" turn on default spell checking
"set spell

" disable spellcapcheck
set spc=

" more risky, but cleaner
set nobackup
set noswapfile
set nowritebackup

" Fuzzy finder
set path+=**
set wildignore+=**/node_modules/**

set icon

" center the cursor always on the screen
"set scrolloff=999

" highlight search hits
set hlsearch
set incsearch
set linebreak

" avoid most of the 'Hit Enter ...' messages
set shortmess=aoOtTI

" prevents truncated yanks, deletes, etc.
set viminfo='20,<1000,s1000

" not a fan of bracket matching or folding
if has("eval") " vim-tiny detection
  let g:loaded_matchparen=1
endif
set noshowmatch

" wrap around when searching
set wrapscan
set nowrap

" Just the formatoptions defaults, these are changed per filetype by
" plugins. Most of the utility of all of this has been superceded by the use of
" modern simplified pandoc for capturing knowledge source instead of
" arbitrary raw text files.

set fo-=t   " don't auto-wrap text using text width
set fo+=c   " autowrap comments using textwidth with leader
set fo-=r   " don't auto-insert comment leader on enter in insert
set fo-=o   " don't auto-insert comment leader on o/O in normal
set fo+=q   " allow formatting of comments with gq
set fo-=w   " don't use trailing whitespace for paragraphs
set fo-=a   " disable auto-formatting of paragraph changes
set fo-=n   " don't recognized numbered lists
set fo+=j   " delete comment prefix when joining
set fo-=2   " don't use the indent of second paragraph line
set fo-=v   " don't use broken 'vi-compatible auto-wrapping'
set fo-=b   " don't use broken 'vi-compatible auto-wrapping'
set fo+=l   " long lines not broken in insert mode
set fo+=m   " multi-byte character line break support
set fo+=M   " don't add space before or after multi-byte char
set fo-=B   " don't add space between two multi-byte chars
set fo+=1   " don't break a line after a one-letter word

" stop complaints about switching buffer with changes
set hidden

" command history
set history=100

" here because plugins and stuff need it
if has("syntax")
  syntax enable
endif

" faster scrolling
set ttyfast

" allow sensing the filetype
filetype plugin on

" high contrast for streaming, etc.
set background=dark

" make gutter less annoying
hi SignColumn ctermbg=NONE

au FileType * hi StatusLine ctermbg=NONE ctermfg=gray
au FileType * hi VertSplit ctermbg=NONE ctermfg=gray
au FileType * hi StatusLineNC ctermbg=NONE ctermfg=gray

set cinoptions+=:0

" Edit/Reload vimrc configuration file
nnoremap confe :e $HOME/.vimrc<CR>
nnoremap confr :source $HOME/.vimrc<CR>

" only load plugins if Plug detected
if filereadable(expand('~/.vim/autoload/plug.vim'))

  " github.com/junegunn/vim-plug

  call plug#begin('~/.local/share/vim/plugins')
  " Theme
  Plug 'conradirwin/vim-bracketed-paste'
  Plug 'jeffkreeftmeijer/vim-dim'

  " Markdown/pandoc stuff
  Plug 'vim-pandoc/vim-pandoc', { 'for': 'pandoc' }
  Plug 'rwxrob/vim-pandoc-syntax-simple', { 'for': 'pandoc' }
  Plug 'Chandlercjy/vim-markdown-edit-code-block'
  Plug 'dbridges/vim-markdown-runner', {'for': 'pandoc'}

  " Coding
  Plug 'dense-analysis/ale', { 'for': ['typescript', 'go', 'haskell', 'rust'] }
  Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }

  " Misc
  Plug 'neovimhaskell/haskell-vim'
  Plug 'andlrc/CTRLGGitBlame.vim'
  Plug 'bogado/file-line'
  Plug 'pbrisbin/vim-mkdir'
  Plug 'tpope/vim-vinegar'
  " Plug 'Exafunction/codeium.vim'

  if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  endif
  call plug#end()

  let g:ale_sign_error = '😡'
  let g:ale_sign_warning = '🙄'
  let g:ale_lint_on_enter = 0
  let g:ale_fix_on_save = 1
  let g:ale_linters = {
        \ 'typescript': ['eslint', 'tsserver'], 
        \ 'go': ['gometalinter', 'gofmt', 'gobuild'], 
        \ 'haskell': ['hls'],
        \ 'rust': ['rust_analyzer']
        \}
  let g:ale_fixers = {'typescript': ['prettier'], 'rust': ['rustfmt']}
  let g:ale_use_neovim_diagnostics_api = has('nvim')

  autocmd FileType typescript,haskell,rust nnoremap <buffer> <c-]> <cmd>ALEGoToDefinition<cr>
  autocmd FileType typescript,haskell,rust nnoremap <buffer> <c-w>] <c-w>v<cmd>ALEGoToDefinition<cr>
  autocmd FileType typescript,haskell,rust nnoremap <buffer> ]d <cmd>ALENextWrap<cr>
  autocmd FileType typescript,haskell,rust nnoremap <buffer> [d <cmd>ALEPreviousWrap<cr>
  autocmd FileType typescript,haskell,rust nnoremap <buffer> ga <cmd>ALECodeAction<cr>
  autocmd FileType typescript,haskell,rust nnoremap <buffer> K <cmd>ALEHover<cr>
  autocmd FileType typescript,haskell,rust nnoremap <buffer> rn <cmd>ALERename<cr>
  autocmd FileType typescript,haskell,rust setlocal omnifunc=ale#completion#OmniFunc

  " pandoc
  let g:pandoc#formatting#mode = 'h' " A'
  let g:pandoc#formatting#textwidth = 72

  let g:markdown_runners = {
        \ '': getenv('SHELL'),
        \ 'go': function('markdown_runner#RunGoBlock'),
        \ 'js': 'node',
        \ 'javascript': 'node',
        \ 'ts': 'bun',
        \ 'typescript': 'bun',
        \ 'haskell': 'runghc',
        \ 'vim': function("markdown_runner#RunVimBlock"),
        \ }

  autocmd FileType pandoc nmap <buffer> <silent> <leader>e :MarkdownEditBlock<CR>
  autocmd FileType pandoc nmap <buffer> <silent> <leader>r :MarkdownRunnerInsert<CR>

  " golang
  let g:go_fmt_fail_silently = 0
  let g:go_fmt_command = 'goimports'
  let g:go_fmt_autosave = 1
  let g:go_gopls_enabled = 1
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_variable_declarations = 1
  let g:go_highlight_variable_assignments = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_diagnostic_errors = 1
  let g:go_highlight_diagnostic_warnings = 1
  "let g:go_auto_type_info = 1 " forces 'Press ENTER' too much
  let g:go_auto_sameids = 0
  "    let g:go_metalinter_command='golangci-lint'
  "    let g:go_metalinter_command='golint'
  "    let g:go_metalinter_autosave=1
  set updatetime=100
  "let g:go_gopls_analyses = { 'composites' : v:false }
  au FileType go nmap <leader>m ilog.Print("made")<CR><ESC>
  au FileType go nmap <leader>n iif err != nil {return err}<CR><ESC>

  colorscheme dim
else
  autocmd vimleavepre *.go !gofmt -w % " backup if fatih fails
endif

" force loclist to always close when buffer does (affects vim-go, etc.)
augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

" format perl on save
if has("eval") " vim-tiny detection
  fun! s:Perltidy()
    let l:pos = getcurpos()
    silent execute '%!perltidy -i=2'
    call setpos('.', l:pos)
  endfun
  "autocmd FileType perl autocmd BufWritePre <buffer> call s:Perltidy()
endif

" format shell on save
if has("eval") " vim-tiny detection
  " TODO check for shfmt and shellcheck before defining
  " FIXME stop from blowing away file when there is shell error
  fun! s:FormatShell()
    let l:pos = getcurpos()
    "silent execute '%!shfmt' " FIXME: bug report to shfmt
    call setpos('.', l:pos)
  endfun
  autocmd FileType sh autocmd BufWritePre <buffer> call s:FormatShell()
endif

" make Y consistent with D and C (yank til end)
map Y y$

" better command-line completion
set wildmenu

" better cursor movement
"set virtualedit=all
set wrap

" disable search highlighting with <C-L> when refreshing screen
nnoremap <C-L> :nohl<CR><C-L>

" enable omni-completion
set omnifunc=syntaxcomplete#Complete
imap <tab><tab> <c-x><c-o>

"fix bork bash detection
if has("eval")  " vim-tiny detection
  fun! s:DetectBash()
    if getline(1) == '#!/usr/bin/bash' || getline(1) == '#!/bin/bash'
      set ft=bash
      set shiftwidth=2
    endif
  endfun
  autocmd BufNewFile,BufRead * call s:DetectBash()
endif

" displays all the syntax rules for current position, useful
" when writing vimscript syntax plugins
if has("syntax")
  function! <SID>SynStack()
    if !exists("*synstack")
      return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endfunc
endif


" start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" functions keys
map <F1> :set number!<CR> :set relativenumber!<CR>
nmap <F2> :call <SID>SynStack()<CR>
set pastetoggle=<F3>
map <F4> :set list!<CR>
map <F5> :set cursorline!<CR>
map <F7> :set spell!<CR>
map <F12> :set fdm=indent<CR>

nmap <leader>2 :set paste<CR>i

let g:split_fuzzy_cmd = "vs | fin"

cabbrev vf <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? g:split_fuzzy_cmd : 'vf')<CR>

" Better page down and page up
noremap <C-n> <C-d>
noremap <C-p> <C-b>

if has('nvim')
lua<<EOF
local signs = { Error = "😡", Warn = "🙄" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "typescript", "tsx" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {"ruby"},
  },
}
EOF
endif
