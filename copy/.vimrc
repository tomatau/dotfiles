" Pathgen first ------------------------------------------------------------
call pathogen#infect()

" important ----------------------------------------------------------------
set nocompatible

" moving around, searching and patterns ------------------------------------
set incsearch " show search as you type
set showmatch " jump to matching bracket
set ignorecase " when lowercase, include uppercase
set smartcase " when mixed, be specific
set mouse=a " use mouse navigation

" displaying text ---------------------------------------------------------- 
set number
set linebreak " wraps between words
set wrap
set scrolloff=3 " distance from edge on scroll

" syntax, highlighting and spelling ----------------------------------------
set hlsearch " highlight search results
set background=light " :se bg

" multiple windows ---------------------------------------------------------

" messages and info --------------------------------------------------------
set cursorline "underline cursor
set showcmd " show normal etc commands in bottom right
set ruler " show custor position e.g. 26:41

" editing text -------------------------------------------------------------
set nrformats-=octal " remove octal for 0 prefix nums (ctrl a and ctrl x)
set backspace=indent,eol,start

" tabs and indefing --------------------------------------------------------
set autoindent " maintains indent on next line
set smartindent " indents for condition etc
set expandtab " tabs become spaces
set shiftwidth=4 " v mode
set softtabstop=4 " i mode
set tabstop=4 " n mode?
set shiftround " round > and < to multiples of shiftwidth
set list listchars=tab:»-,trail:·,extends:»,precedes:«

autocmd InsertEnter *.* set list!
autocmd InsertLeave *.* set list!

" folding ------------------------------------------------------------------
"set foldmethod=marker
"set foldmarket={{{,}}}

" mapping ------------------------------------------------------------------
set timeout
set timeoutlen=1000
set ttimeoutlen=100 " these 3 make capital o (insert above line) faster

" various ------------------------------------------------------------------
set gdefault " global search and replaces
set noswapfile " remove swap file from home dir
set fileencoding=utf-8
set encoding=utf-8
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999
set ts=4 sts=4 sw=4 expandtab " Default whitespace managing

" badwolf codeschool jellybeans lizard
" mustang oceandeep tomatosoup solarized
" hybrid kolor desertedoceanburnt
" colorscheme --------------------------------------------------------------
colorscheme desertedoceanburnt
set t_Co=256 " full colours
filetype indent plugin on
syntax enable
let mapleader = ","

" Mappings -----------------------------------------------------------------   
nnoremap \ :NERDTreeToggle<CR>
" rebind \
nnoremap <leader>\ \
" dsiable search select
nnoremap <leader><space> :noh<CR>
" auto complete
inoremap <S-Tab> <C-n>
" save file
inoremap <C-s> <Esc>:w<CR>a
vnoremap <C-s> :w<CR>
nnoremap <C-s> :w<CR>
" tabbing
nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >>
vnoremap <S-TAB> <<
" delete word
inoremap <C-d> <C-o>diw

" airline ------------------------------------------------------------------
set laststatus=2 " Use 2 lines for the statusbar
let g:airline_theme='dark'
" let g:airline_powerline_fonts=1
let g:airline_enable_branch=1
let g:airline#extensions#tabline#enabled = 1
" let g:airline_enable_syntastic=1
" let g:airline_exclude_filenames=[]
" let g:airline_exclude_filetypes=[]

augroup AutoReloadVimRC
    " automatically reload vimrc when it's saved
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
