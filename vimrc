" setup Vundle

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'


" colour scheme

Bundle 'sjl/badwolf'
color badwolf
set background=dark

" Files

Bundle 'scrooloose/nerdtree'
nmap <C-u> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

Bundle 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = ''

set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc,tmp,*.scssc,*.pyc
set wildmenu

" Python

Bundle 'michaeljsmith/vim-indent-object'
Bundle 'davidhalter/jedi-vim'
Bundle 'tmhedberg/SimpylFold'
nnoremap <space> za
vnoremap <space> zf
let g:indentobject_meaningful_indentation = ["python", "markdown", "ocaml"]
autocmd FileType python setlocal completeopt-=preview

" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" OCaml
Bundle 'OCamlPro/ocp-indent'

" General 

set nu
set numberwidth=3
set mouse=a
syntax on
set autoread

" disable ugly gtk stuff
set guioptions-=m
set guioptions-=M
set guioptions-=T
set guioptions-=e
set guifont=Source\ Code\ Pro

" Whitespace
set backspace=indent,eol,start
set autoindent
set tabstop=4
set softtabstop=4
set textwidth=80
set shiftwidth=4
set noexpandtab
set wrap
set formatoptions=qrn1
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:␣
set cindent

Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"

" nice status line
Bundle 'bling/vim-airline'
let g:airline_powerline_fonts=1
set laststatus=2
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_linecolumn_prefix = '¶'
" let g:airline_branch_prefix = ' '
let g:airline_branch_prefix = ''
let g:airline_paste_symbol = 'ρ'
let g:airline_whitespace_symbol = 'Ξ'

" Disable the scrollbars
set guioptions-=r
set guioptions-=L

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" balancing
" Bundle 'AutoClose'
Bundle 'Raimondi/delimitMate'

" Clojure
Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-fireplace.git'
Bundle 'tpope/vim-classpath.git'
let g:clojure_lambda_conceal=1

" Slime
Bundle 'jpalardy/vim-slime'
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"

" We do utf-8
scriptencoding utf-8
set encoding=utf-8

" Load up virtualenv's vimrc if it exists
if filereadable($VIRTUAL_ENV . '/vimrc')
    source $VIRTUAL_ENV/vimrc
endif

