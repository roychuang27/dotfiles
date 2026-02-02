se nu ru cul cin aw ai is ts=4 sw=4 noeb bg=dark
sy on
nmap <leader>\ :!g++ % -std=c++17 -D local&& ./a.out && rm a.out<CR>

" edited from the overthewire version

set background=dark
if has("autocmd")
  filetype plugin indent on
endif
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ignorecase          " Do case insensitive matching
set smartcase           " Do smart case matching
set incsearch           " Incremental search
nnoremap <expr> n 'Nn'[v:searchforward]
" n always search forward
nnoremap <expr> N 'nN'[v:searchforward]
" N always search backward
set autowrite           " Automatically save before commands like :next and :make
set hidden              " Hide buffers when they are abandoned
set mouse=""            " Disable mouse usage (all modes)
set viminfo=""
set nobackup       " no backup files
set noswapfile     " no swap files
set nowritebackup  " only in case you don't want a backup file while editing
set noundofile     " no undo files

set foldmethod=indent
set foldlevel=99
nnoremap <space> za
set ruler
set laststatus=2 "always show status line
set statusline=%F%m%r%h%w\ [dec=\%3.3b]\ [hex=\%02.2B]\ [pos=%04l:%04v][%p%%\ of\ %L]

set wildmenu
set wildignore=.o,.exe,.dll,.so,.*~

if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

set report=0

set noerrorbells
set t_vb=
set visualbell

set history=250

set showcmd

set incsearch
set hlsearch
"set noignorecase
set ignorecase
set magic "extended regexes

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set ts=4

set autoindent
set smartindent
set cindent

hi CursorLine   cterm=NONE ctermbg=8 " ctermfg=white
hi CursorColumn cterm=NONE ctermbg=8 " ctermfg=white
set nocursorline
set nocursorcolumn

noremap  <F4> :set cursorline! cursorcolumn!<CR>
inoremap <F4> <ESC>:set cursorline! cursorcolumn!<CR>i

set pastetoggle=<F3>

set number
noremap  <F2> :set nonumber!<CR>
inoremap <F2> <ESC>:set nonumber!<CR>i

nmap ,, <C-]> "jump to tag
nmap <CR> i<CR><ESC>
"nmap <TAB> ==
" auto indent
nmap -- gg=G''
" unhilight search
imap <silent> <C-C> <ESC>:nohlsearch<CR>a
nmap <silent> <C-C> :nohlsearch<CR>

set backspace=indent,eol,start

autocmd CompleteDone * pclose

set encoding=utf-8

set completeopt=longest,menuone,preview "preview shows a nice preview window of the function...
"set completeopt=longest,menuone,preview
"set completeopt=longest,menuone

let python_highlight_all = 1
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set list
" set listchars=tab:>-,trail:~,extends:>,precedes:<,space:·
set listchars=tab:>-,trail:~,extends:>,precedes:<
set mouse=a
set guioptions=
set nowrap
