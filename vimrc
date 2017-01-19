set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" themes
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline-themes'

" filetypes
Plugin 'pangloss/vim-javascript'
Plugin 'groenewege/vim-less'
Plugin 'plasticboy/vim-markdown'

" features
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-vinegar'
Plugin 'danro/rename.vim'
Plugin 'vim-airline/vim-airline'

" editing
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-entire'

call vundle#end()
filetype plugin indent on

syntax on

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set visualbell
set hlsearch
set incsearch
set showmatch
set backspace=indent,eol,start
set ignorecase
set smartcase
set wildmenu
set wildmode=longest:full
set wildignore+=*/tmp/*,*.class,*.swp,*.jar
set spell
set list
set listchars=tab:▸\ ,
set ruler
set formatoptions=qrn1
set colorcolumn=85
set splitright
set laststatus=2
set tags=tags;
set scrolloff=10
set foldlevel=99
set mouse=nicr

autocmd ColorScheme * highlight LineNr ctermfg=6 ctermbg=100
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * hi! link SignColumn LineNr
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
autocmd BufWinEnter * silent! :%foldopen!

autocmd filetype html,xml setlocal tabstop=2
autocmd filetype html,xml setlocal shiftwidth=2

nnoremap j gj
nnoremap k gk

nnoremap Y y$

inoremap jj <ESC>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let mapleader = ","
let maplocalleader = ","
nnoremap \ ,

nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>eV :e $MYVIMRC<cr>
nnoremap <leader>s :set spell!<cr>

colorscheme solarized
set background=light

let g:airline_powerline_fonts = 1

function! <SID>StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

nnoremap <silent> <leader><space> :call <SID>StripTrailingWhitespace()<CR>
