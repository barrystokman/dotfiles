set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'fcpg/vim-farout'
Plugin 'fcpg/vim-fahrenheit'
Plugin 'fcpg/vim-orbital'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'arcticicestudio/nord-vim'
Plugin 'morhetz/gruvbox'
Plugin 'vim-gitgutter'
" Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" set space as leader key
let mapleader = "\<Space>"

" set cursorline
set cursorline

" specify areas where splits (:sp for horizontal and :vs for vertical) should occur
set splitbelow
set splitright

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" set write to both :W and :w
map :W :w

" search highlight
set hlsearch

" clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" show docstrings for folded code
let g:SimpylFold_docstring_preview=1

" set YouCompleteMe to correct python version, depending on machine
" Firelink = private, Lothric = work

if hostname() == "Lothric"
   "let g:ycm_server_python_interpreter = '/home/barry/miniconda3/bin/python3'
   let g:ycm_server_python_interpreter = '/home/barry/anaconda3/bin/python3'
elseif hostname() == "hasta.scilifelab.se"
   let g:ycm_server_python_interpreter = '/home/proj/bin/conda/bin/python3'
elseif hostname() == "Firelink"
   let g:ycm_server_python_interpreter = '/usr/local/bin/python3'
endif

" close autocomplete window when done
let g:ycm_autoclose_preview_window_after_completion=1

" shortcut for goto definition
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" add proper PEP8 indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=99 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" flag unnecessary whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" set utf-8 encoding
set encoding=utf-8

" set line numbers
set number

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" make code look pretty ^______^
let python_highlight_all=1
syntax on

" set background to dark so vim displays right colors in tmux
set background=dark

syntax enable
colorscheme farout
colorscheme fahrenheit
colorscheme nord
colorscheme gruvbox

" nord italics 
let g:nord_italic = 1
let g:nord_italic = 1

" hide .pyc files
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" needed for powerline
set laststatus=2

" map CTRL-n to open NERDTree
map <C-n> :NERDTreeToggle<CR>

" close vim if only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NerdCommenter -> don't follow indentation 
let g:NERDDefaultAlign = 'left'
