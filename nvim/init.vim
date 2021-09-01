" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

augroup loadPlugin
  autocmd!
  autocmd vimEnter * call DeferLoadPlugins()
        \ | autocmd! loadPlugin
augroup END

function! Handlers(_)
  " 0. before load
  " 1. load plugins
  call plug#load('dashboard-nvim', 'vim-nerdtree-syntax-highlight', 'vim-devicons', 'nerdtree', 'vim-airline', 'vim-airline-themes', 'vim-clap', 'nerdcommenter', 'minimap.vim')

  " execute("Minimap")

endfunction

function! DeferLoadPlugins()
  return timer_start(0, 'Handlers', { 'repeat': 1 })
endfunction
"------------------ plugins-list------------------"
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'iCyMind/NeoSolarized'
" Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-gruvbox8'
" Plug 'liuchengxu/vista.vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'ayu-theme/ayu-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'wfxr/minimap.vim', { 'on': [] }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'glepnir/dashboard-nvim'
" Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'ryanoasis/vim-devicons'
Plug 'posva/vim-vue', {'for': ['vue']}
" Plug 'tpope/vim-fugitive'
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install', 'for': [ 'markdown', 'md']}
Plug 'leafgarland/typescript-vim', {'for': ['typescript']}
Plug 'preservim/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'sheerun/vim-polyglot'
Plug 'Chiel92/vim-autoformat'
Plug 'jremmen/vim-ripgrep'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'heavenshell/vim-jsdoc', {'for': ['javascript', 'javascript.jsx','typescript'], 'do': 'make install'}
" Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
Plug 'luochen1990/rainbow'
Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }
" Plug 'rust-lang/rust.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim'

" Plug 'maxmellon/vim-jsx-pretty', {'for': [ 'javascript', 'javascript.jsx', 'typescript', 'typescript.tsx']}

" coc extensions
"
let g:node_host_prog = system('volta which neovim-node-host | tr -d "\n"')
let g:coc_global_extensions = [
        \ 'coc-git', 'coc-lists', 'coc-word', 'coc-dictionary', 'coc-emoji', 'coc-highlight', 'coc-pairs', 'coc-yank',
        \ 'coc-vimlsp', 'coc-tsserver', 'coc-vetur', 'coc-html', 'coc-css', 'coc-json', 'coc-yaml', 'coc-flutter',
        \ 'coc-prettier', 'coc-jest',
        \ 'coc-stylelintplus',
        \ 'coc-snippets', 'coc-rust-analyzer',
        \ 'https://github.com/xabikos/vscode-javascript',
        \ 'coc-translator',
        \]

let g:python3_host_prog = '/usr/local/bin/python3.9'

" Initialize plugin system
call plug#end()

let s:script_cwd = expand('<sfile>:p:h')
let s:source_list = ['config']

for s:item in s:source_list
  let s:path = split(globpath(s:script_cwd . '/' . s:item, '*.vim'), '\n')
  for s:cfg in s:path
    if filereadable(s:cfg)
      execute 'source' . s:cfg
    endif
  endfor

endfor

lua << EOF
require("bufferline").setup{}
EOF

unlet s:script_cwd
unlet s:source_list
