" be vim instead of vi
set nocompatible


" display line numbers
set nu

" display "-- INSERT --" when entering insert mode
set showmode

" incremental search
set incsearch

" highlight matching search terms
set hlsearch

" set ic means case-insensitive search; noic means case-sensitive.
set noic

" allow backspacing over any character in insert mode
set backspace=indent,eol,start

" do not wrap lines
set nowrap

" set the mouse to work in the console
set mouse=a
" keep 50 lines of command line history
set history=50
" show the cursor position
set ruler
" do incremental searching
set incsearch
" save a backup file
set backup

" the visual bell flashes the background instead of an audible bell.
set visualbell

" set sensible defaults for different types of text files.
au FileType c set cindent tw=79
au FileType sh set ai et sw=4 sts=4 noexpandtab
au FileType vim set ai et sw=2 sts=2 noexpandtab

" indent new lines to match the current indentation
set autoindent
" don’t replace tabs with spaces
set noexpandtab
" use tabs at the start of a line, spaces elsewhere
set smarttab
" show syntax highlighting
syntax on

" show whitespace at the end of a line
highlight WhitespaceEOL ctermbg=blue guibg=blue
match WhitespaceEOL /\s\+$/




" This tells vim to figure out what type of file it's looking at
" and load the appropriate plugin
filetype indent plugin on


let mapleader=","
map <Leader>qq :q<enter>
map <Leader>ff :Ex<enter>
map <Leader>fs :w<enter>
map <Leader>' :shell<enter>
map <Leader>bb :buffers<enter>
map <Leader>bd :bd<enter>

imap fd <esc>
