" general config {
    set nocompatible            " Must be first line
    filetype on                 "open file type support
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8
    set encoding=UTF-8
    set lazyredraw              " Don't redraw while executing macros (good performance config)
    set magic                   " For regular expressions turn magic on
    "set autoread                " 
    set modeline
    set relativenumber              " Line numbers on
    " 使用系统粘贴板
    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    " 随机函数
    function! RandInt(Low, High) abort
        let l:milisec = str2nr(matchstr(reltimestr(reltime()), '\v\.\zs\d+'))
        return l:milisec % (a:High - a:Low + 1) + a:Low
    endfunction

    " 当打开缓冲区的时候，自动切换目录 
    " autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set nospell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    " set iskeyword-=.                    " '.' is an end of word designator
    " set iskeyword-=#                    " '#' is an end of word designator
    " set iskeyword-=-                    " '-' is an end of word designator

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    function! ResCur()
        if line("'\"") <= line("$")
            silent! normal! g`"
            return 1
        endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END
    " Setting up the directories {
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

        " To disable views add the following to your .vimrc.before.local file:
        "   let g:spf13_no_views = 1
        let g:skipview_files = [
            \ '\[example pattern\]'
            \ ]
    " }
" }

" UI  config {
    set number
    set relativenumber              " Line numbers on
    hi NonText ctermbg=none
    " hi MatchParen cterm=none ctermbg=90 ctermfg=46         " 括号匹配颜色
    set termguicolors
    set background=dark " Assume a dark background
    let g:gruvbox_italic=1
    let g:gruvbox_italicize_strings=1
    let g:gruvbox_hls_cursor='gray'
    " let g:gruvbox_filetype_hi_groups = 1
    " let g:gruvbox_italicize_strings = 1
    " let g:gruvbox_plugin_hi_groups = 1
    let g:gruvbox_termcolors='256'
    let g:gruvbox_contrast_dark='hard'
    let g:rainbow_active = 1
    let g:gruvbox_material_background = 'hard'
    let g:everforest_background = 'hard'
    let g:gruvbox_material_enable_bold = 1
    let g:gruvbox_material_enable_italic = 1
    let my_colorschemes = ["nightfly", "spaceduck", "gruvbox-material", "onedark", "PaperColor", "everforest", "dracula"]
    execute "colorscheme" my_colorschemes[RandInt(0, 6)]
    " colorscheme onedark
    " colorscheme gruvbox-material
    set cursorline
    set cursorcolumn
    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    highlight CursorColumn cterm=NONE ctermbg=NONE ctermfg=brown guibg=NONE guifg=NONE
    set scrolloff=10                " Minimum lines to keep above and below cursor
    set showmatch                   " Show matching brackets/parenthesis
    autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
    set showmode                    " Display the current mode
    set ruler                       " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                     " Show partial commands in status line and

    if has('statusline')
        set laststatus=2

        " broken down into easily includeable segments
        set statusline=%<%f\                     " filename
        set statusline+=%w%h%m%r                 " options
        set statusline+=\ [%{&ff}/%y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=%=%-14.(%l,%c%v%)\ %p%%  " right aligned file nav info
    endif
    set foldenable                  " Auto fold code
    set fdm=indent
    set foldlevelstart=99
    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    "set incsearch                   " Find as you type search
    "set hlsearch                    " Highlight search terms
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
" }

" Formatting {
    set autoindent                  " Indent at the same level of the previous line
    set nowrap                      " Do not wrap long lines
    set shiftwidth=2                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=2                   " An indentation every four columns
    set softtabstop=2               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer>
    autocmd FileType json syntax match Comment +\/\/.\+$+
    " augroup FiletypeGroup
      " autocmd!
      " au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
    " augroup END
    " autocmd CursorHold * silent call CocActionAsync('highlight')
" }

" Key (re)Mappings {
    imap jj <Esc>
    let mapleader=","
    " Run javascript code {
        vmap <leader>r :w !node<cr>
    " }
    " Buffer next and Buffer pre {
      nmap <C-j> :bp<cr>
      map <C-j> :bp<cr>
      nmap <C-h> :b#<cr>
      map <C-h> :b#<cr>
      vmap <C-j> :bp<cr>
      nmap <C-k> :bn<cr>
      map <C-k> :bn<cr>
      vmap <C-k> :bn<cr>
      map <C-a> :%bd\|e#\|bd#<cr>\|'"
      nmap <C-a> :%bd\|e#\|bd#<cr>\|'"
      nmap <C-d> :bd<cr>
      map <C-d> :bd<cr>
      vmap <C-d> :bd<cr>
      nmap <silent> gb :BufferLinePick<CR>
    " }
    " Save && Quit {
      imap <leader>s <Esc>:w<cr>
      nmap <leader>s <Esc>:w<cr>
      nmap <leader>q <Esc>:q!<cr>
      vmap <leader>q <Esc>:q!<cr>
    " }
    " Coc-todo-list {
      " nmap <leader>c :CocCommand todolist.create<cr>
      " nmap <leader>d :CocCommand todolist.clearRemind<cr>
    " }
    " Coc-translator {
      nmap <leader>t <Plug>(coc-translator-p)
    " }
" }
