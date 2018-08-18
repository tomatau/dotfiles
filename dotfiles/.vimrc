execute pathogen#infect()
" general settings
set nocompatible " use vim mode, not vi mode
filetype on " identify file according to type
filetype indent on
filetype plugin on
let mapleader = ","
set fileencoding=utf-8 " encoding when writing file
set encoding=utf-8 " encoding when reading
set noswapfile
set wildmenu

" general appearance
syntax enable
set number
set showcmd
set ruler " show line and col number of cursor in bottom
set cursorline " underline cursor
set cc=80 " shows ruler at 80
set wrap
set linebreak
set scrolloff=3
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" navigation and search
set incsearch " search as type, requires explitic return
set ignorecase
set smartcase " when mixed search
set hlsearch " highlight search results, needs :nohlsearch to disable
set mouse=a " use mouse navigation
set showmatch " show the matching bracket

" editing text
set backspace=indent,eol,start
set nrformats-=octal

" tabs and indentation
set autoindent " maintains indentation for next line
set smartindent " indents for blocks
set tabstop=2 " normal mode
set softtabstop=2 " insert mode
set shiftwidth=2 " esc & v mode
set expandtab " tabs to spaces
set shiftround " round > and < to multiples of shiftwidth
set list listchars=tab:»-,trail:·,extends:»,precedes:«

" windows
set winheight=5
set winminheight=5
set winheight=999
set winwidth=84

" make commands expect to b
set timeout
set timeoutlen=1000
set ttimeoutlen=100

" syntax
au BufRead,BufNewFile *.es6 setfiletype javascript
au BufRead,BufNewFile *.jsx setfiletype javascript
au BufRead,BufNewFile *.es setfiletype javascript

" automatically reload vimrc when saved
augroup AutoReloadVimRC
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" COLOR SCHEME
set t_Co=256 " full colours
colorscheme jellybeans

" PLUGINS
" airline
set laststatus=2 " use 2 lines for statusbar
let g:airline_theme='dark'
let g:airline_enable_branch=1
let g:airline#extensions#tabline#enabled=1
" jsx
let g:jsx_ext_required=0
let g:jsx_pragma_required=0

" MAPPINGS
inoremap <S-Tab> <C-n>
" saving files
inoremap <C-s> <Esc>:w<CR>a
vnoremap <C-s> :w<CR>gv
nnoremap <C-s> :w<CR>
" interface
nnoremap \ :NERDTreeToggle<CR>
