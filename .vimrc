" Vimster .vimrc is a Vim setup made by BjornW
" Inspired by the work of Steve Francia (spf13), Steve Losh & many others

"0. Required defaults
   set nocompatible    " Needed for more advanced options. VI compatibility not needed
   set background=dark " What can I say, I'm a fan of oldskool dark terminals :)

"1. Vundle configuration 
   filetype off
   set rtp+=~/.vim/bundle/vundle
   call vundle#rc()

" Vundle bundles are configured in .vimrc.bundles
    if filereadable(expand("~/.vimrc.bundles"))
      source ~/.vimrc.bundles
    endif

"2. General stuff
   filetype plugin indent on  " Automagically detect file types
   syntax enable              " Use syntax highlighting
   set number                 " Use line numbers   			
   set mouse=a                " Automagically enable mouse usage
   set mousehide              " Hide mousecursor while typing

   " Automagically switch to current file directory when opening a new buffer
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

   " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

   set autowrite                       " Automatically write a file when leaving a modified buffer
   set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
   set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
   set virtualedit=onemore             " Allow for cursor beyond last character
   set history=1000                    " Store a ton of history (default is 20)
   set spell                           " Spell checking on
   set nobackup                        " Backups are for people without version controear
   set hidden                          " Allow buffer switching without savin
   if has('persistent_undo')
     set undofile                           " So is persistent undo ...
     set undodir=~/.vim/persistent-undo     " Keep all persisent undo files in one place, no .file.un~ all over anymore             	
     set undolevels=1000                    " Maximum number of changes that can be undone
     set undoreload=10000                   " Maximum number lines to save for undo on a buffer reload
   endif

"3. UI
   " Use Solarized or fall back to default vim colorscheme desert
   if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
     "let g:solarized_termcolors=256
     colorscheme solarized                 " Load a colorscheme
     let g:solarized_termtrans=1
     let g:solarized_contrast="high"
     let g:solarized_visibility="high"
     set t_Co=16 " Make solarized gnome-terminal behave with vim solarized, byobu
   elseif 
     "color desert	    
   endif
   
   set tabpagemax=15 " Only show 15 tabs
   set showmode      " Display the current mode
   set cursorline    " Highlight current line

   if has('cmdline_info')
     set ruler                   " Show the ruler
     set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
     set showcmd                 " Show partial commands in status line and
   " Selected characters/lines in visual mode
   endif

   if has('statusline')
     set laststatus=2

     " Broken down into easily includeable segments
     set statusline=%<%f\                     " Filename
     set statusline+=%w%h%m%r                 " Options
     set statusline+=%{fugitive#statusline()} " Git Hotness
     set statusline+=\ [%{&ff}/%Y]            " Filetype
     set statusline+=\ [%{getcwd()}]          " Current dir
     set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
   endif

   set backspace=indent,eol,start  " Backspace for dummies
   set linespace=0                 " No extra spaces between rows
   set showmatch                   " Show matching brackets/parenthesis
   set incsearch                   " Find as you type search
   set ignorecase                  " Case insensitive search
   set smartcase                   " Case sensitive when uc present
   set wildmenu                    " Show list instead of just completing
   set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
   set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
   set scrolljump=5                " Lines to scroll when cursor leaves screen
   set scrolloff=3                 " Minimum lines to keep above and below cursori
  

"4. Formatting {
    set nowrap                      " Wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=2                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=2                   " An indentation every four columns
    set softtabstop=2               " Let backspace delete indent



 

