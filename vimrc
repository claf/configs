" disable context :
"let loaded_ctx=1

"This will look in the current directory for "tags",
"and work up the tree towards root until one is found.
set tags=tags;/

"cscope thing :
if has("cscope")
    set csprg=/opt/local/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif

" syntax higlighting :
syntax on

" turn off compatibility with the old vim:
set nocompatible

" automatically show matching bracket :
set showmatch

" mac issue? :
set backspace=indent,eol,start


filetype on
au BufNewFile,BufRead *.cilk set filetype=cpp
colorschem desert 
set hlsearch
set et
set sw=2
set smarttab

" Jerome :
set autoindent
set expandtab
set softtabstop=2
set tabstop=2
set cindent
set nocp

set updatetime=250
" line number :
set number

filetype plugin on
filetype indent on
"filetype plugin indent on

command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis

function! s:DiffWithGITCheckedOut()
  let filetype=&ft
  diffthis
  vnew | exe "%!git diff " . expand("#:p:h") . "| patch -p 1 -Rs -o /dev/stdout"
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  diffthis
endfunction
com! DiffGIT call s:DiffWithGITCheckedOut()

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

