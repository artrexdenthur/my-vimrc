if has("unix")
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Environment
Plug 'itchyny/lightline.vim' " 'Light and Configurable' status bar
" File Explorer (We'll see)
Plug 'scrooloose/nerdtree'

" Class Outline Viewer
Plug 'majutsushi/tagbar'

" Fuzzy Search
Plug 'ctrlpvim/ctrlp.vim'

" Ack (Grep replacement, plugged in to Vim)
Plug 'mileszs/ack.vim'

" Find and Replace in multiple files
Plug 'brooth/far.vim'

" Syntax checker (simple linter?)
Plug 'vim-syntastic/syntastic'

" Autocomplete
Plug 'Valloric/YouCompleteMe' " As-you-type completion
" Plug 'othree/vim-autocomplpop' "Automatic trigger complete popup menu
Plug 'tpope/endwise' " Autocompletes 'end's for Ruby

" Snippets
Plug 'garbas/vim-snipmates' " A snippet support plugin
Plug 'honza/vim-snippets' " A snippet repository

" Ruby, courtesy of tpope
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rvm'
Plug 'ngmy/vim-rubocop' " ... and ngmy

" Tests
Plug 'janko-m/vim-test'

" Additional syntaxes and markup/programming languages
Plug 'sheerun/vim-polyglot' " The one and only!

" Git
Plug 'airblade/vim-gitgutter' " Shows a git diff in the gutter and stages/undoes hunks
Plug 'tpope/vim-fugitive' " Git wrapper with a great name
Plug 'rhysd/commitia.vim' " Better editing on commit messages
Plug 'int3/vim-extradite' " Git commit browser

" Other
Plug 'airblade/vim-rooter' " changes Vim working directory to project root
Plug 'tyru/caw.vim' " comments
Plug 'Raimondi/delimitMate' " insert mode auto-complete for quotes, etc.
Plug 'sickill/vim-pasta' " pasting in Vim adjusts to local tabs
Plug 'mattn/emmet-vim' " Emmet-like abbreviation expansion
Plug 'bogado/file-line' " Allows opening a file to a specific line (for error searching)
Plug 'google/vim-searchindex' " Shows the count of matches and index of current match


call plug#end()

" The real settings (many from https://github.com/amix/vimrc)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <F8> :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu
set wildmode=longest,list,full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" No annoying sound on errors
set visualbell

" Add a bit extra margin to the left
set foldcolumn=1

""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Tab to tabstops rather than blindly inputting two spaces
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on (wraps but won't break words)
set lbr

set ai "autoindent
set si "Smart indent

" Backspace works like it should
set backspace=indent,eol,start

""""""""""""""""""""""""""""""""""""""""
" => Visual Mode Stuff
""""""""""""""""""""""""""""""""""""""""
" In Visual mode, pressing * or # searches for the current selection for or back, resp.
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


""""""""""""""""""""""""""""""
" => Search Options
""""""""""""""""""""""""""""""
" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" start searching as characters are entered
set incsearch

" highlight matches
set hlsearch              

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction


function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
