syn on
set bg=dark
colorscheme moxokai
set hlsearch
set modeline
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim
"set rtp+=$HOME/git/powerline/powerline/bindings/vim
set laststatus=2
set noshowmode
" eventually needed for TERM=xterm-256color compatibility, comment this out
" if you experience errors.
set bs=2
command Wq wq
command Q q
au FileType xml exe ":silent %!xmllint --format --recover - 2>/dev/null"

if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python
endif

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

set tabstop=4
set shortmess+=I
set showtabline=2
highlight Normal ctermbg=234

