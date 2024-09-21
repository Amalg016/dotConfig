set tabstop=4
set shiftwidth=4
set softtabstop=4

"set termguicolors
set nospell
set noerrorbells

"set autoread
set number
set relativenumber


set clipboard=unnamed
set nostartofline
set backspace=indent,eol,start

set expandtab
set cursorline
set autoindent
set smartindent

set formatoptions=tcqrnl
" Show file stats
set ruler

" Do not save backup files.
set nobackup
" Do not let cursor scroll below or above N number of lines when scrolling.
"set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" set regexpengine=0
set mouse=a
set encoding=utf-8
set spelllang=en_us

" Rendering
set ttyfast

" Show the mode you are on the last line.
set showmode
" Show matching words during a search.
set showmatch
set hlsearch
set incsearch
set ignorecase    " Ignore case when searching
set smartcase     " Use case-sensitive search if a capital letter is used
set showcmd

" Related to fileSearch and other fileSystems
set wildmenu
set wildmode=full
"set hidden

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm


"set hlsearch
"colorscheme scheakur
colorscheme wildcharm
set background=dark
hi NonText ctermbg=none
hi Normal guibg=NONE ctermbg=NONE


set statusline=%f\ %m\ %r%h%w%y[%{&fileencoding}]%=\ Line:%l/%L\ Col:%c\ %P
set laststatus=2



"File Browser
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\( '
"
"
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
