execute pathogen#infect()


set nocompatible                        "Apparently its necessary (https://stackoverflow.com/a/5845583)

set t_Co=256                            "Needed for color schemes to work right
syntax on
syntax enable

"This is the most necessary thing ever. Who has time to hit ESC?!
"Also super helpful on newer macbooks where ESC is in that stupid touch bar
inoremap jj <ESC>l
