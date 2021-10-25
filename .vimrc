" be vim instead of vi
set nocompatible
" turn on syntax highlighting
syntax on

" display line numbers
set nu

" This tells vim to figure out what type of file it's looking at
" and load the appropriate plugin
filetype indent plugin on


let mapleader=" "
map <Leader>qq :q<enter>
map <Leader>ff :Ex<enter>
map <Leader>fs :w<enter>

imap fd <esc>

