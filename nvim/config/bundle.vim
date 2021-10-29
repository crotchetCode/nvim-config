" Plugin vim-coc {
  " TextEdit might fail if hidden is not set.
  set hidden

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Give more space for displaying messages.
  set cmdheight=2

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <leader>c :CocDiagnostics<CR>
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>k  <Plug>(coc-format-selected)
  nmap <leader>k  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Remap <C-f> and <C-b> for scroll float windows/popups.
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  endif

  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of language server.
  " nmap <silent> <C-s> <Plug>(coc-range-select)
  " xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings for CoCList
  " Show all diagnostics.
  " nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
  " " Manage extensions.
  " nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  " " Show commands.
  " nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  " " Find symbol of current document.
  " nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " " Search workspace symbols.
  " nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  " " Do default action for next item.
  " nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " " Do default action for previous item.
  " nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  " " Resume latest coc list.
  " nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"}

"Plugin coc-git {
  nmap <silent> <leader>go :CocCommand git.browserOpen<CR>
  " show chunk diff at current position
  " show commit at current position
  nmap <leader>gc <Plug>(coc-git-commit)
"}

" 补全 {
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? coc#_select_confirm() :
        \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  let g:coc_snippet_next = '<tab>'

  " expand vue snippet - @see https://github.com/iamcco/dotfiles/blob/master/nvim/viml/plugins.config/coc.nvim.vim#L52
  function! s:vue_snippet() abort
      let l:start_line = line('.')
      let l:is_position = search('\v%x0')
      if l:is_position !=# 0
          silent! s/\v\t/    /g
          silent! s/\v%x0\n//g
          silent! s/\v%x0/\r/g
          let l:end_line = line('.')
          call cursor(l:start_line, 0)
          let l:pos = searchpos('\v\$\{\d+\}', 'n', l:end_line)
          if l:pos[0] !=# 0 && l:pos[1] !=# 0
              call cursor(l:pos[0], l:pos[1])
              normal! df}
          endif
      endif
  endfunction

  " vue
  autocmd CompleteDone *.vue call <SID>vue_snippet()
  " highlight text color, default #000000
  autocmd ColorScheme * highlight! CocHighlightText guibg=#909399 ctermbg=023

  " coc.nvim - multi-cursors
  command! -nargs=0 RenameCurrentWord :CocCommand document.renameCurrentWord
  nmap <silent> <C-x> :CocCommand document.renameCurrentWord<CR>
  nmap <silent> <C-s> <Plug>(coc-cursors-word)

  " coc.nvim - prettier
  command! -nargs=0 Prettier :CocCommand prettier.formatFile
  nmap <leader>p :Prettier<CR>
  vmap <leader>p <Plug>(coc-format-selected)
" }

" Plugin vim-ariline & indent line{
  let g:airline_theme='alduin'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#formatter = 'default'
  let g:indentLine_setColors = 0
  let g:indentLine_char = '┆'
  let g:indentLine_conceallevel = 2
"}

" Plugin ense-analysis/ale{
  let g:ale_sign_column_always = 1
  let g:ale_sign_error = '✗'
  let g:ale_sign_warning = '⚡️'
  let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
  highlight clear ALEErrorSign
  highlight clear ALEWarningSign
  let g:ale_echo_msg_error_str = 'E'
  let g:ale_echo_msg_warning_str = 'W'
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
  function! LinterStatus() abort
      let l:counts = ale#statusline#Count(bufnr(''))

      let l:all_errors = l:counts.error + l:counts.style_error
      let l:all_non_errors = l:counts.total - l:all_errors

      return l:counts.total == 0 ? 'OK' : printf(
      \   '%dW %dE',
      \   all_non_errors,
      \   all_errors
      \)
  endfunction
  set statusline=%{LinterStatus()}
  let b:ale_linter_aliases = ['javascript', 'vue', 'css']
  " Select the eslint and vls linters.
  let b:ale_linters = ['eslint', 'vls', 'stylelint']

"}

" Plugin markdown-preview{
" mapping
  nnoremap <silent> <leader>mp :MarkdownPreview<CR>
  " set to 1, nvim will open the preview window after entering the markdown buffer
  " default: 0
  let g:mkdp_auto_start = 0

  " set to 1, the nvim will auto close current preview window when change
  " from markdown buffer to another buffer
  " default: 1
  let g:mkdp_auto_close = 1

  " set to 1, the vim will refresh markdown when save the buffer or
  " leave from insert mode, default 0 is auto refresh markdown as you edit or
  " move the cursor
  " default: 0
  let g:mkdp_refresh_slow = 0

  " set to 1, the MarkdownPreview command can be use for all files,
  " by default it can be use in markdown file
  " default: 0
  let g:mkdp_command_for_global = 0

  " set to 1, preview server available to others in your network
  " by default, the server listens on localhost (127.0.0.1)
  " default: 0
  let g:mkdp_open_to_the_world = 0

  " use custom IP to open preview page
  " useful when you work in remote vim and preview on local browser
  " more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
  " default empty
  let g:mkdp_open_ip = ''

  " specify browser to open preview page
  " default: ''
  let g:mkdp_browser = ''

  " set to 1, echo preview page url in command line when open preview page
  " default is 0
  let g:mkdp_echo_preview_url = 0

  " a custom vim function name to open preview page
  " this function will receive url as param
  " default is empty
  let g:mkdp_browserfunc = ''

  " options for markdown render
  " mkit: markdown-it options for render
  " katex: katex options for math
  " uml: markdown-it-plantuml options
  " maid: mermaid options
  " disable_sync_scroll: if disable sync scroll, default 0
  " sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
  "   middle: mean the cursor position alway show at the middle of the preview page
  "   top: mean the vim top viewport alway show at the top of the preview page
  "   relative: mean the cursor position alway show at the relative positon of the preview page
  " hide_yaml_meta: if hide yaml metadata, default is 1
  " sequence_diagrams: js-sequence-diagrams options
  " content_editable: if enable content editable for preview page, default: v:false
  " disable_filename: if disable filename header for preview page, default: 0
  let g:mkdp_preview_options = {
      \ 'mkit': {},
      \ 'katex': {},
      \ 'uml': {},
      \ 'maid': {},
      \ 'disable_sync_scroll': 0,
      \ 'sync_scroll_type': 'middle',
      \ 'hide_yaml_meta': 1,
      \ 'sequence_diagrams': {},
      \ 'flowchart_diagrams': {},
      \ 'content_editable': v:false,
      \ 'disable_filename': 0
      \ }

  " use a custom markdown style must be absolute path
  " like '/Users/username/markdown.css' or expand('~/markdown.css')
  let g:mkdp_markdown_css = ''

  " use a custom highlight style must absolute path
  " like '/Users/username/highlight.css' or expand('~/highlight.css')
  let g:mkdp_highlight_css = ''

  " use a custom port to start server or random for empty
  let g:mkdp_port = ''

  " preview page title
  " ${name} will be replace with the file name
  let g:mkdp_page_title = '「${name}」'

  " recognized filetypes
  " these filetypes will have MarkdownPreview... commands
  let g:mkdp_filetypes = ['markdown']
" }

" Plugin nerdtree {
  map <C-e> :NERDTreeToggle<CR>
  map <leader>e  :NERDTreeFind<CR>
  nmap <leader>e  :NERDTreeFind<CR>
  let NERDTreeShowBookmarks=1
  let NERDTreeIgnore=['\.py[cd]$', 'node_modules', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
  let NERDTreeChDirMode=0
  let NERDTreeQuitOnOpen=1
  let NERDTreeMouseMode=2
  let NERDTreeShowHidden=1
  let NERDTreeKeepTreeInNewTab=1
  let g:nerdtree_tabs_open_on_gui_startup=0
" }

" Plugin devicons {
  set guifont=<FONT_NAME>:h<FONT_SIZE>
  if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
  endif
  let g:airline_powerline_fonts = 1
  let g:webdevicons_enable_vimfiler = 0
  let g:webdevicons_conceal_nerdtree_brackets = 1
  let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
  let g:WebDevIconsNerdTreeGitPluginForceVAlign = 0
" }
"
" Plugin Xuyuanp/nerdtree-git-plugin {
  let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
" }

" Plugin nerdcommenter }
  let g:NERDSpaceDelims = 1
  let g:rainbow_active = 1
  let g:rainbow_conf = {
        \	'separately': {
        \		'nerdtree': 0,
        \	}
        \}
" }

" Plugin LeaderF {
  " search word under cursor, the pattern is treated as regex, and enter normal mode directly
  " noremap <leader>f :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
  " search word under cursor, the pattern is treated as regex,
  " append the result to previous search results.
  " noremap <leader>g :<C-U><C-R>=printf("Leaderf! rg --append -e %s ", expand("<cword>"))<CR>
  " search word under cursor literally only in current buffer
  " noremap <leader>b :<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -e %s ", expand("<cword>"))<CR>
  " search visually selected text literally, don't quit LeaderF after accepting an entry
  " xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F --stayOpen -e %s ", leaderf#Rg#visual())<CR>
  " recall last search. If the result window is closed, reopen it.
  " noremap go :<C-U>Leaderf! rg --stayOpen --recall<CR>
  " let g:Lf_WindowPosition = 'popup'
  " let g:Lf_ShortcutF = '<C-P>'
  " let g:Lf_WorkingDirectoryMode = 'Ac'
  " let g:Lf_UseMemoryCache = 0
  " let g:Lf_UseCache = 0
  " let g:Lf_WorkingDirectory = finddir('.git', '.;')
" }
" Plugin fugitive {
  nnoremap <silent> <leader>gs :Git<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gb :Git blame<CR>
  nnoremap <silent> <leader>gl :Gclog<CR>
" }

" Plugin vim-jsdoc {
  let g:jsdoc_formatter = 'tsdoc'
  nmap <silent> <C-l> <Plug>(jsdoc)
" }
"
" https://github.com/wfxr/minimap.vim {{
  let g:minimap_auto_start = 0
  " 同时展示 lightline mode & percent 的最小宽度是 20
  let g:minimap_width = 20
" }}
"
" " Plugin vista{
  " map <C-a>  :Vista!!<CR>

  " let g:vista_sidebar_width = 45
  " function! NearestMethodOrFunction() abort
    " return get(b:, 'vista_nearest_method_or_function', '')
  " endfunction

  " set statusline+=%{NearestMethodOrFunction()}

  " " By default vista.vim never run if you don't call it explicitly.
  " "
  " " If you want to show the nearest function in your statusline automatically,
  " " you can add the following line to your vimrc 
  " autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
  " " How each level is indented and what to prepend.
  " " This could make the display more compact or more spacious.
  " " e.g., more compact: ["▸ ", ""]
  " " Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
  " let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

  " " Executive used when opening vista sidebar without specifying it.
  " " See all the avaliable executives via `:echo g:vista#executives`.
  " let g:vista_default_executive = 'coc'

  " " Set the executive for some filetypes explicitly. Use the explicit executive
  " " instead of the default one for these filetypes when using `:Vista` without
  " " specifying the executive.
  " let g:vista_executive_for = {
    " \ 'js': 'coc',
    " \ 'ts': 'coc'
    " \ }

  " " Declare the command including the executable and options used to generate ctags output
  " " for some certain filetypes.The file path will be appened to your custom command.
  " " For example:
  " let g:vista_ctags_cmd = {
        " \ 'haskell': 'hasktags -x -o - -c',
        " \ }

  " " Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
  " let g:vista#renderer#enable_icon = 1

  " " The default icons can't be suitable for all the filetypes, you can extend it as you wish.
  " " let g:vista#renderer#icons = {
  " \   "function": "\uf794",
  " \   "variable": "\uf71b",
  " " \  }
" " }

"" https://github.com/leafgarland/typescript-vim {
  " fix filetype
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
"}

" Plugins vim-nerdtree-syntax-highlight {
  let s:git_orange = 'F54D27'
  let g:NERDTreeExtensionHighlightColor = {}
  let g:NERDTreeExtensionHighlightColor['vue'] = '42b883'
  let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
  let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files
  let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
  let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
" }
"
" Plugins vim-clap {
  let g:clap_multi_selection_warning_silent=1
  " nnoremap <silent> <leader>gb :Clap bcommits<CR>
  " nnoremap <silent> <leader>gc :Clap commits<CR>
  " nnoremap <silent> <leader>gd :Clap git_diff_files<CR>
  nnoremap <silent> <leader>f :Clap grep2<CR>
  nnoremap <silent> <leader>ff :Clap grep2 ++query=<cword><CR>
  vnoremap <silent> <leader>f :Clap grep2 ++query=@visual<CR>
  nnoremap <silent> <C-p> :Clap files<CR>
" }
"
" Plugins dashboard-nvim {
  let g:indentLine_fileTypeExclude = ['dashboard']
  autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
" }
" Plugins vim-svelte {
  let g:vim_svelte_plugin_load_full_syntax = 1
  let g:vim_svelte_plugin_use_typescript = 1
  let g:vim_svelte_plugin_use_less = 1
  let g:vim_svelte_plugin_use_sass = 1
" }
