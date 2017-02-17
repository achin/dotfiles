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
Plugin 'tpope/vim-ragtag'
Plugin 'danro/rename.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'mileszs/ack.vim'

" editing
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-entire'

" unite
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/neoyank.vim'

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
set mouse=a

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

" unite settings
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>ff :<C-u>Unite -no-split -prompt=»\  -buffer-name=files   -start-insert file<cr>
nnoremap <leader>ft :<C-u>Unite -no-split -prompt=»\  -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>fe :<C-u>Unite -no-split -prompt=»\  -buffer-name=buffer  buffer<cr>
nnoremap <leader>fy :<C-u>Unite -no-split -prompt=»\  -buffer-name=yank    history/yank<cr>

colorscheme solarized
set background=light

let g:airline_powerline_fonts = 1

function! <SID>StripTrailingWhitespace()
    if &modifiable
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " Do the business:
        %s/\s\+$//e
        " Clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endif
endfunction

nnoremap <silent> <leader><space> :call <SID>StripTrailingWhitespace()<CR>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
