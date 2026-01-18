" plugin support through vim-plug
execute plug#begin()
Plug 'kadekillary/Turtles'
Plug 'dracula/vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tcomment_vim'
call plug#end()

set nocompatible                        "Apparently its necessary (https://stackoverflow.com/a/5845583)

set t_Co=256                            "Needed for color schemes to work right
set termguicolors                       "uses highlight-guifg and highlight-guibg attributes (24-bit color)
syntax on
syntax enable
colorscheme turtles
"hi Normal guibg=NONE ctermbg=NONE       "Allow for transparent background

filetype plugin on                      "Enables filetype plugins
filetype plugin indent on               "Indents based on filetypes
set omnifunc=syntaxcomplete#Complete	"does something; i assume for vim-go

set undofile                            "Allow for undoing AFTER a file is :wq
set undodir=$HOME/.vim/undo             "Dir used for undo

set wildmenu                            "Menu tab-completion on the command line
set number                              "Display line numbers
set ruler                               "Always show current position
set backspace=indent,eol,start          "Allow delete over end of line and indent characters
set cc=99				"Set line at column 99

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
let g:go_code_completion_enabled = 1
au Filetype go nnoremap <leader>gr :GoRun %<CR>

"vim-airline config
let g:airline_theme = 'turtles'
let g:airline_powerline_fonts = 1                       "displays arrows, terminal must have a powerline font
let g:airline#extensions#tabline#enabled = 1            "automatically display all buffers (even one tab)
let g:airline#extensions#tabline#formatter = 'default'

"a few quick cuts custom mapping using ','
let mapleader=","
nmap <leader>p :set paste! <CR> :set nu! <CR>
nmap <leader>nn :set nu! <CR>
nmap <leader>w :w! <CR>
nmap <leader>/ :TComment <CR>

"tagbar config
nmap <F8> :TagbarToggle<CR>

"nerdtree config
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1                                                     "show hidden files
let NERDTreeIgnore=['\.swp']                                                 "ignore swap files
let NERDTreeMapOpenInTab='<ENTER>'                                           "open files from NERDTree in new tab
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif  "open a NERDTree automatically when vim starts up if no files were specified

" tab complete for omnicomplete
inoremap <tab> <c-r>=Smart_TabComplete("")<CR>
inoremap <s-tab> <c-r>=Smart_TabComplete("shift")<CR>
function! Smart_TabComplete(shift)
	if (pumvisible())
		return empty(a:shift) ? "\<C-n>" : "\<C-p>"
	endif

	let line = getline('.')				" get current line

	let substr = strpart(line, -1, col('.')+1)	" from the start of the current line
							" to one character right of the cursor

	let substr = matchstr(substr, "[^ \t]*$")	" word till cursor
	if (strlen(substr)==0)
		return "\<tab>"
	endif
	let has_period = match(substr, '\.') != -1	" position of period, if any
	let has_slash = match(substr, '\/') != -1	" position of slash, if any
	if (!has_period && !has_slash)
		return "\<C-X>\<C-P>"			" existing text matching
	elseif ( has_slash )
		return "\<C-X>\<C-F>"			" file matching
	else
		return "\<C-X>\<C-O>"			" plugin matching
	endif
endfunction
