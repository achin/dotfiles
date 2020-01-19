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
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-vinegar.git'
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

" clojure
Plugin 'bhurlow/vim-parinfer'

" unite
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/neoyank.vim'

call vundle#end()
filetype plugin indent on

syntax on

set tabstop=2
set shiftwidth=2
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
autocmd ColorScheme * hi! link SignColumn LineNr
autocmd BufWinLeave * call clearmatches()
autocmd BufWinEnter * silent! :%foldopen!

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

" unite settings
call unite#filters#matcher_default#use(['matcher_fuzzy', 'sorter_selecta'])
call unite#custom#source('file_rec/async', 'ignore_pattern', 'target/')

nnoremap <leader>f :<C-u>Unite -no-split -prompt=»\  -buffer-name=files  file<cr>
nnoremap <leader>t :<C-u>Unite -no-split -prompt=»\  -buffer-name=files  file_rec/async:!<cr>
nnoremap <leader>b :<C-u>Unite -no-split -prompt=»\  -buffer-name=buffer buffer<cr>
nnoremap <leader>g :<C-u>Unite -no-split -prompt=»\  -buffer-name=grep   grep:.<cr>
nnoremap <leader>y :<C-u>Unite -no-split -prompt=»\  -buffer-name=yank   history/yank<cr>

if executable('ag')
    let g:unite_source_rec_async_command =
        \ ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']

    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
        \ '-i --vimgrep --nocolor --nogroup '
endif

" interface
colorscheme solarized
set background=light

let g:airline_powerline_fonts = 1
let g:airline_detect_spell = 0

" trailing whitespace
function! <SID>ShouldMatchWhitespace()
    for ft in ['unite']
        if ft ==# &filetype | return 0 | endif
    endfor
    return 1
endfunction

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

highlight default ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufRead,BufNew,BufWinEnter * if <SID>ShouldMatchWhitespace() | match ExtraWhitespace /\s\+$/ | else | match ExtraWhitespace /^^/ | endif
autocmd InsertEnter * if <SID>ShouldMatchWhitespace() | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
autocmd InsertLeave * if <SID>ShouldMatchWhitespace() | match ExtraWhitespace /\s\+$/ | endif

nnoremap <silent> <leader><space> :call <SID>StripTrailingWhitespace()<CR>

" ack/ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" vinegar
function! <SID>setup_vinegar()
    nnoremap <buffer> q <C-^>
    nunmap <buffer> qL
    nunmap <buffer> qF
    nunmap <buffer> qf
    nunmap <buffer> qb
    set nolist
endfunction

autocmd FileType netrw call <SID>setup_vinegar()
