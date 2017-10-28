execute pathogen#infect()

set nocompatible                        "Apparently its necessary (https://stackoverflow.com/a/5845583)

set t_Co=256                            "Needed for color schemes to work right
syntax on
syntax enable

filetype plugin on                      "Enables filetype plugins
filetype plugin indent on               "Indents based on filetypes

set undofile                            "Allow for undoing AFTER a file is :wq
set undodir=$HOME/.vim/undo             "Dir used for undo


set wildmenu                            "Menu tab-completion on the command line
set number                              "Display line numbers
set ruler                               "Always show current position

set ai                                  "Auto Indent
set si                                  "Smart Indent

set hlsearch                            "Highlight Search
set ignorecase                          "Case insensitive search

set tabstop=2                           "Set Tabs to proper location
set shiftwidth=2                        "Indenting is X spaces
set expandtab                           "Don't use actual tab character (C-v)



"This is the most necessary thing ever. Who has time to hit ESC?!
"Also super helpful on newer macbooks where ESC is in that stupid touch bar
inoremap jj <ESC>l
"
"Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
