execute pathogen#infect()
"current plugins:
" - vim-gitgutter             https://github.com/airblade/vim-gitgutter
" - RelOps                    https://github.com/vim-scripts/RelOps
" - vim-java-unused-imports   https://github.com/akhaku/vim-java-unused-imports
" - vim-go                    https://github.com/fatih/vim-go
" - vim-trailing-whitespace   https://github.com/bronson/vim-trailing-whitespace

set nocompatible                        "Apparently its necessary (https://stackoverflow.com/a/5845583)

set t_Co=256                            "Needed for color schemes to work right
syntax on
syntax enable
colorscheme _molokai                    "Colors: _SolarizedDark  _molokai  github  solarized

filetype plugin on                      "Enables filetype plugins
filetype plugin indent on               "Indents based on filetypes

set undofile                            "Allow for undoing AFTER a file is :wq
set undodir=$HOME/.vim/undo             "Dir used for undo


set wildmenu                            "Menu tab-completion on the command line
set number                              "Display line numbers
set ruler                               "Always show current position
set backspace=indent,eol,start          "Allow delete over end of line and indent characters

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

"Allow saving of files as sudo when I forget to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"vim-go Config
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
au Filetype go nnoremap <leader>gr :GoRun %<CR>
