call plug#begin('~/.config/nvim/plugged')

" General {{{
    " Abbreviations
    abbr funciton function
    abbr teh the
    abbr tempalte template
    abbr fitler filter
    abbr cosnt const
    abbr attribtue attribute
    abbr attribuet attribute

    set autoread " detect when a file is changed

    set history=1000 " change history to 1000
    set textwidth=120

    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

    if (has('nvim'))
        " show results of substition as they're happening
        " but don't open a split
        set inccommand=nosplit
    endif

    set backspace=indent,eol,start " make backspace behave in a sane manner
    set clipboard=unnamed

    if has('mouse')
        set mouse=a
    endif

    " Searching
    set ignorecase " case insensitive searching
    set smartcase " case-sensitive if expresson contains a capital letter
    set hlsearch " highlight search results
    set incsearch " set incremental search, like modern browsers
    set nolazyredraw " don't redraw while executing macros

    set magic " Set magic on, for regex

    " error bells
    set noerrorbells
    set visualbell
    set t_vb=
    set tm=500
" }}}

" Appearance {{{
    " colorscheme
    Plug 'felixhummel/setcolors.vim'
    Plug 'yuttie/inkstained-vim'
    Plug 'yuttie/hydrangea-vim'
    Plug 'KKPMW/sacredforest-vim'
    Plug 'patstockwell/vim-monokai-tasty'
    Plug 'nightsense/snow'
    Plug 'ayu-theme/ayu-vim'
    Plug 'junegunn/seoul256.vim'
    set termguicolors

    set number " show line numbers
    set cursorline
    set wrap " turn on line wrapping
    set wrapmargin=8 " wrap lines when coming within n characters from side
    set linebreak " set soft wrapping
    set showbreak=… " show ellipsis at breaking
    set autoindent " automatically set indent of new line
    set ttyfast " faster redrawing
    set diffopt+=vertical
    set laststatus=2 " show the satus line all the time
    set so=7 " set 7 lines to the cursors - when moving vertical
    set wildmenu " enhanced command line completion
    set hidden " current buffer can be put into background
    set showcmd " show incomplete commands
    set noshowmode " don't show which mode disabled for PowerLine
    set wildmode=list:longest " complete files like a shell
    set scrolloff=3 " lines of text around cursor
    set shell=$SHELL
    set cmdheight=1 " command bar height
    set title " set terminal title
    set showmatch " show matching braces
    set mat=2 " how many tenths of a second to blink

    " Tab control
    set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    set tabstop=2 " the visible width of tabs
    set shiftwidth=2 " number of spaces to use for indent and unindent
    set expandtab

    " code folding settings
    set foldmethod=syntax " fold based on indent
    set foldlevelstart=99
    set foldnestmax=10 " deepest fold is 10 levels
    set nofoldenable " don't fold by default
    set foldlevel=1

    " toggle invisible characters
    set list
    set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
    set showbreak=↪

    " set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
    if (has("termguicolors"))
      set termguicolors
    endif
    " let ayucolor="mirage"

    " highlight conflicts
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

    " LightLine {{{
        Plug 'itchyny/lightline.vim'
        let g:lightline = {
        \   'colorscheme': 'hydrangea',
        \   'active': {
        \       'left': [ [ 'mode', 'paste' ],
        \               [ 'gitbranch' ],
        \               [ 'readonly', 'filetype', 'filename', 'fliptable' ]],
        \       'right': [ [ 'percent' ], [ 'lineinfo' ],
        \               [ 'fileformat', 'fileencoding' ],
        \               [ 'linter_errors', 'linter_warnings' ]]
        \   },
        \   'component_expand': {
        \       'linter': 'LightlineLinter',
        \       'linter_warnings': 'LightlineLinterWarnings',
        \       'linter_errors': 'LightlineLinterErrors',
        \       'linter_ok': 'LightlineLinterOk'
        \   },
        \   'component_type': {
        \       'readonly': 'error',
        \       'linter_warnings': 'warning',
        \       'linter_errors': 'error'
        \   },
        \   'component_function': {
        \       'fileencoding': 'LightlineFileEncoding',
        \       'filename': 'LightlineFileName',
        \       'fileformat': 'LightlineFileFormat',
        \       'filetype': 'LightlineFileType',
        \       'gitbranch': 'LightlineGitBranch'
        \   },
        \   'component': {
        \       'fliptable': '(╯°□°）╯︵ ┻━┻'
        \   },
        \   'tabline': {
        \       'left': [ [ 'tabs' ] ],
        \       'right': [ [ 'close' ] ]
        \   },
        \   'tab': {
        \       'active': [ 'filename', 'modified' ],
        \       'inactive': [ 'filename', 'modified' ],
        \   },
        \   'separator': { 'left': '', 'right': '' },
        \   'subseparator': { 'left': '', 'right': '' }
        \ }
        " \   'separator': { 'left': '▓▒░', 'right': '░▒▓' },
        " \   'subseparator': { 'left': '▒', 'right': '░' }

        function! LightlineFileName() abort
            let filename = winwidth(0) > 70 ? expand('%') : expand('%:t')
            if filename =~ 'NERD_tree'
                return ''
            endif
            let modified = &modified ? ' +' : ''
            return fnamemodify(filename, ":~:.") . modified
        endfunction

        function! LightlineFileEncoding()
            " only show the file encoding if it's not 'utf-8'
            return &fileencoding == 'utf-8' ? '' : &fileencoding
        endfunction

        function! LightlineFileFormat()
            " only show the file format if it's not 'unix'
            let format = &fileformat == 'unix' ? '' : &fileformat
            return winwidth(0) > 70 ? format . ' ' . WebDevIconsGetFileFormatSymbol() : ''
        endfunction

        function! LightlineFileType()
            return WebDevIconsGetFileTypeSymbol()
            " return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
        endfunction

        function! LightlineLinter() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            return l:counts.total == 0 ? '' : printf('×%d', l:counts.total)
        endfunction

        function! LightlineLinterWarnings() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:counts.total == 0 ? '' : '⚠ ' . printf('%d', all_non_errors)
        endfunction

        function! LightlineLinterErrors() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            return l:counts.total == 0 ? '' : '✖ ' . printf('%d', all_errors)
        endfunction

        function! LightlineLinterOk() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            return l:counts.total == 0 ? 'OK' : ''
        endfunction

        function! LightlineGitBranch()
            return "\uE725" . (exists('*fugitive#head') ? fugitive#head() : '')
        endfunction

        function! LightlineUpdate()
            if g:goyo_entered == 0
                " do not update lightline if in Goyo mode
                call lightline#update()
            endif
        endfunction

        augroup alestatus
            autocmd User ALELint call LightlineUpdate()
        augroup end
    " }}}
" }}}

" General Mappings {{{
    noremap <Up> <NOP>
    noremap <Down> <NOP>
    noremap <Left> <NOP>
    noremap <Right> <NOP> 
    " set a map leader for more key combos
    let mapleader = ','

    " remap esc
    inoremap jk <esc>

    " shortcut to save
    nmap <leader>, :w<cr>

    " set paste toggle
    set pastetoggle=<leader>v

    " edit ~/.config/nvim/init.vim
    map <leader>ev :e! ~/.config/nvim/init.vim<cr>
    " edit gitconfig
    map <leader>eg :e! ~/.gitconfig<cr>

    " clear highlighted search
    noremap <space> :set hlsearch! hlsearch?<cr>

    " activate spell-checking alternatives
    nmap ;s :set invspell spelllang=en<cr>

    " markdown to html
    nmap <leader>md :%!markdown --html4tags <cr>

    " remove extra whitespace
    nmap <leader><space> :%s/\s\+$<cr>
    nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

    inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
    inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

    nmap <leader>l :set list!<cr>

    " Textmate style indentation
    vmap <leader>[ <gv
    vmap <leader>] >gv
    nmap <leader>[ <<
    nmap <leader>] >>

    " switch between current and last buffer
    nmap <leader>. <c-^>

    " enable . command in visual mode
    vnoremap . :normal .<cr>

    map <leader>wc :wincmd q<cr>

    " move line mappings
    nnoremap <silent> <C-j> :m .+1<cr>==
    nnoremap <silent> <C-k> :m .-2<cr>==
    inoremap <silent> <C-j> <Esc>:m .+1<cr>==gi
    inoremap <silent> <C-k> <Esc>:m .-2<cr>==gi
    vnoremap <silent> <C-j> :m '>+1<cr>gv=gv
    vnoremap <silent> <C-k> :m '<-2<cr>gv=gv

    vnoremap $( <esc>`>a)<esc>`<i(<esc>
    vnoremap $[ <esc>`>a]<esc>`<i[<esc>
    vnoremap ${ <esc>`>a}<esc>`<i{<esc>
    vnoremap $" <esc>`>a"<esc>`<i"<esc>
    vnoremap $' <esc>`>a'<esc>`<i'<esc>
    vnoremap $\ <esc>`>o*/<esc>`<O/*<esc>
    vnoremap $< <esc>`>a><esc>`<i<<esc>

    " toggle cursor line
    nnoremap <leader>i :set cursorline!<cr>

    " scroll the viewport faster
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>

    " moving up and down work as you would expect
    nnoremap <silent> j gj
    nnoremap <silent> k gk
    nnoremap <silent> ^ g^
    nnoremap <silent> $ g$

    " helpers for dealing with other people's code
    nmap \t :set ts=4 sts=4 sw=4 noet<cr>
    nmap \s :set ts=4 sts=4 sw=4 et<cr>

    nnoremap <silent> <leader>u :call functions#HtmlUnEscape()<cr>

    command! Rm call functions#Delete()
    command! RM call functions#Delete() <Bar> q!
" }}}

" AutoGroups {{{
    " file type specific settings
    augroup configgroup
        autocmd!

        " automatically resize panes on resize
        autocmd VimResized * exe 'normal! \<c-w>='
        autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
        autocmd BufWritePost .vimrc.local source %
        " save all files on focus lost, ignoring warnings about untitled buffers
        autocmd FocusLost * silent! wa

        " make quickfix windows take all the lower section of the screen
        " when there are multiple windows open
        autocmd FileType qf wincmd J
        autocmd FileType qf nmap <buffer> q :q<cr>
    augroup END
" }}}

" General Functionality {{{
    " better terminal integration
    " Plug 'wincent/terminus'
    " substitute, search, and abbreviate multiple variants of a word
    Plug 'tpope/vim-abolish'

    Plug 'itchyny/calendar.vim'
    let g:calendar_google_calendar = 1

    " search inside files using ripgrep. This plugin provides an Ack command.
    Plug 'wincent/ferret'

    " insert or delete brackets, parens, quotes in pair
    Plug 'jiangmiao/auto-pairs'
    let g:AutoPairsShortcutFastWrap = '<C-w>'

    " easy commenting motions
    Plug 'tpope/vim-commentary'

    " mappings which are simply short normal mode aliases for commonly used ex commands
    Plug 'tpope/vim-unimpaired'

    " endings for html, xml, etc. - ehances surround
    Plug 'tpope/vim-ragtag'

    " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
    Plug 'tpope/vim-surround'

    " tmux integration for vim
    Plug 'benmills/vimux'

    " enables repeating other supported plugins with the . command
    Plug 'tpope/vim-repeat'

    " .editorconfig support
    Plug 'editorconfig/editorconfig-vim'

    " asynchronous build and test dispatcher
    Plug 'tpope/vim-dispatch'

    " netrw helper
    Plug 'tpope/vim-vinegar'

    " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
    Plug 'AndrewRadev/splitjoin.vim'

    " extended % matching
    Plug 'vim-scripts/matchit.zip'

    " add end, endif, etc. automatically
    Plug 'tpope/vim-endwise'

    " Fancy startup screen for vim {{{
    Plug 'mhinz/vim-startify'

        " Don't change to directory when selecting a file
        let g:startify_files_number = 5
        let g:startify_change_to_dir = 0
        let g:startify_custom_header = [ ]
        let g:startify_relative_path = 1
        let g:startify_use_env = 1

        function! s:list_commits()
            let git = 'git -C ' . getcwd()
            let commits = systemlist(git . ' log --oneline | head -n5')
            let git = 'G' . git[1:]
            return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
        endfunction

        " Custom startup list, only show MRU from current directory/project
        let g:startify_lists = [
        \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
        \  { 'type': function('s:list_commits'), 'header': [ 'Recent Commits' ] },
        \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
        \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
        \  { 'type': 'commands',  'header': [ 'Commands' ]       },
        \ ]

        let g:startify_commands = [
        \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
        \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
        \ ]

        let g:startify_bookmarks = [
            \ { 'c': '~/personal-projects/dotfiles/nvim/init.vim' },
            \ { 'z': '~/personal-projects/dotfiles/.zshrc' },
            \ { 'g': '~/personal-projects/dotfiles/.gitconfig' }
        \ ]

        autocmd User Startified setlocal cursorline
    " }}}

    " Open selection in carbon.now.sh
    Plug 'kristijanhusak/vim-carbon-now-sh'

    " Close buffers but keep splits
    Plug 'moll/vim-bbye'
    nmap <leader>b :Bdelete<cr>

    " Writing in vim {{{{
        Plug 'junegunn/limelight.vim'
        Plug 'junegunn/goyo.vim'
        let g:limelight_conceal_ctermfg = 240

        let g:goyo_entered = 0
        function! s:goyo_enter()
            silent !tmux set status off
            let g:goyo_entered = 1
            set noshowmode
            set noshowcmd
            set scrolloff=999
            set wrap
            setlocal textwidth=0
            setlocal wrapmargin=0
            Limelight
        endfunction

        function! s:goyo_leave()
            silent !tmux set status on
            let g:goyo_entered = 0
            set showmode
            set showcmd
            set scrolloff=5
            set textwidth=120
            set wrapmargin=8
            Limelight!
        endfunction

        autocmd! User GoyoEnter nested call <SID>goyo_enter()
        autocmd! User GoyoLeave nested call <SID>goyo_leave()
    " }}}

    " context-aware pasting
    Plug 'sickill/vim-pasta'

    " NERDTree {{{
        Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
        " close NERDTree after a file is opened
        let g:NERDTreeQuitOnOpen=1
        Plug 'Xuyuanp/nerdtree-git-plugin'
        Plug 'ryanoasis/vim-devicons'
        Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
        let g:WebDevIconsOS = 'Darwin'
        let g:WebDevIconsUnicodeDecorateFolderNodes = 1
        let g:DevIconsEnableFoldersOpenClose = 1
        let g:DevIconsEnableFolderExtensionPatternMatching = 1
        let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
        let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible
        let g:NERDTreeDirArrows=0

        augroup nerdtree
            autocmd!
            autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
            autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
        augroup END

        " Toggle NERDTree
        function! ToggleNerdTree()
            if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
                :NERDTreeFind
            else
                :NERDTreeToggle
            endif
        endfunction
        " toggle nerd tree
        nmap <silent> <leader>k :call ToggleNerdTree()<cr>
        " find the current file in nerdtree without needing to reload the drawer
        nmap <silent> <leader>y :NERDTreeFind<cr>

        let NERDTreeShowHidden=1
        " let NERDTreeDirArrowExpandable = '▷'
        " let NERDTreeDirArrowCollapsible = '▼'
        let g:NERDTreeIndicatorMapCustom = {
        \ "Modified"  : "✹",
        \ "Staged"    : "✚",
        \ "Untracked" : "✭",
        \ "Renamed"   : "➜",
        \ "Unmerged"  : "═",
        \ "Deleted"   : "✖",
        \ "Dirty"     : "✗",
        \ "Clean"     : "✔︎",
        \ 'Ignored'   : '☒',
        \ "Unknown"   : "?"
        \ }
    " }}}

    " FZF {{{
        Plug '/usr/local/opt/fzf'
        Plug 'junegunn/fzf.vim'
        let g:fzf_layout = { 'down': '~25%' }

        if isdirectory(".git")
            " if in a git project, use :GFiles
            nmap <silent> <leader>t :GitFiles --cached --others --exclude-standard<cr>
        else
            " otherwise, use :FZF
            nmap <silent> <leader>t :FZF<cr>
        endif

        nmap <silent> <leader>s :GFiles?<cr>

        nmap <silent> <leader>r :Buffers<cr>
        nmap <silent> <leader>e :FZF<cr>
        nmap <leader><tab> <plug>(fzf-maps-n)
        xmap <leader><tab> <plug>(fzf-maps-x)
        omap <leader><tab> <plug>(fzf-maps-o)

        " Insert mode completion
        imap <c-x><c-k> <plug>(fzf-complete-word)
        imap <c-x><c-f> <plug>(fzf-complete-path)
        imap <c-x><c-j> <plug>(fzf-complete-file-ag)
        imap <c-x><c-l> <plug>(fzf-complete-line)

        nnoremap <silent> <Leader>C :call fzf#run({
        \   'source':
        \     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
        \         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
        \   'sink':    'colo',
        \   'options': '+m',
        \   'left':    30
        \ })<CR>

        command! FZFMru call fzf#run({
        \  'source':  v:oldfiles,
        \  'sink':    'e',
        \  'options': '-m -x +s',
        \  'down':    '40%'})

        command! -bang -nargs=* Find call fzf#vim#grep(
            \ 'rg --column --line-number --no-heading --follow --color=always '.<q-args>, 1,
            \ <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
        command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
        command! -bang -nargs=? -complete=dir GitFiles
            \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
    " }}}

    " signify {{{
        " Plug 'airblade/vim-gitgutter'
        Plug 'mhinz/vim-signify'
        let g:signify_vcs_list = [ 'git' ]
        let g:signify_sign_add               = '+'
        let g:signify_sign_delete            = '_'
        let g:signify_sign_delete_first_line = '‾'
        let g:signify_sign_change = '!'
    " }}}

    " vim-fugitive {{{
        Plug 'tpope/vim-fugitive'
        Plug 'tpope/vim-rhubarb' " hub extension for fugitive
        Plug 'junegunn/gv.vim'
        Plug 'sodapopcan/vim-twiggy'
        Plug 'christoomey/vim-conflicted'
        nmap <silent> <leader>gs :Gstatus<cr>
        nmap <leader>ge :Gedit<cr>
        nmap <silent><leader>gr :Gread<cr>
        nmap <silent><leader>gb :Gblame<cr>
    " }}}

    " ALE {{{
        Plug 'w0rp/ale' " Asynchonous linting engine
        let g:ale_set_highlights = 0
        let g:ale_change_sign_column_color = 0
        let g:ale_sign_column_always = 1
        let g:ale_sign_error = '✖'
        let g:ale_sign_warning = '⚠'
        let g:ale_echo_msg_error_str = '✖'
        let g:ale_echo_msg_warning_str = '⚠'
        let g:ale_echo_msg_format = '%severity% %s% [%linter%% code%]'
        " let g:ale_completion_enabled = 1

        let g:ale_linters = {
        \   'javascript': ['eslint'],
        \   'typescript': ['tsserver', 'tslint'],
        \   'html': []
        \}
        let g:ale_fixers = {}
        let g:ale_fixers['javascript'] = ['prettier']
        let g:ale_fixers['typescript'] = ['prettier', 'tslint']
        let g:ale_fixers['json'] = ['prettier']
        let g:ale_fixers['css'] = ['prettier']
        let g:ale_javascript_prettier_use_local_config = 1
        let g:ale_fix_on_save = 0
    " }}}
    
    " CoC {{{
      Plug 'neoclide/coc.nvim', {'tag': '*', 'do': 'yarn install'}
     " Use <C-l> for trigger snippet expand.
      imap <C-l> <Plug>(coc-snippets-expand)

      " Use <C-j> for select text for visual placeholder of snippet.
      vmap <C-a> <Plug>(coc-snippets-select)

      " Use <C-j> for jump to next placeholder, it's default of coc.nvim
      let g:coc_snippet_next = '<c-a>'

      " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
      let g:coc_snippet_prev = '<c-o>'

      " Use <C-j> for both expand and jump (make expand higher priority.)
      imap <C-j> <Plug>(coc-snippets-expand-jump)

      inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

      function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      let g:coc_snippet_next = '<tab>'
    " }}}

" }}}

" Language-Specific Configuration {{{
    " html / templates {{{
        " emmet support for vim - easily create markdup wth CSS-like syntax
        Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript.jsx']}
        let g:user_emmet_settings = {
        \  'javascript.jsx': {
        \      'extends': 'jsx',
        \  },
        \}

        " match tags in html, similar to paren support
        Plug 'gregsexton/MatchTag', { 'for': 'html' }

        " html5 support
        Plug 'othree/html5.vim', { 'for': 'html' }

        " mustache support
        Plug 'mustache/vim-mustache-handlebars'

        " pug / jade support
        Plug 'digitaltoad/vim-pug', { 'for': ['jade', 'pug'] }
    " }}}

    " JavaScript {{{
        Plug 'othree/yajs.vim', { 'for': [ 'javascript', 'javascript.jsx', 'html' ] }
        Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'html'] }
        Plug 'moll/vim-node', { 'for': 'javascript' }
        Plug 'mxw/vim-jsx', { 'for': ['javascript.jsx', 'javascript'] }
        Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
        Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
        Plug 'alampros/vim-styled-jsx'
    " }}}
    
    " JSON {{{
        Plug 'elzr/vim-json'
    " }}}

    " TypeScript {{{
        Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
        Plug 'ianks/vim-tsx', { 'for': 'typescript' }
        Plug 'Shougo/vimproc.vim', { 'do': 'make' }

        " Plug 'mhartington/nvim-typescript', { 'for': 'typescript', 'do': './install.sh' }
        " let g:nvim_typescript#diagnostics_enable = 0
        " let g:nvim_typescript#max_completion_detail=100
    " }}}
    
    " Java {{{
        Plug 'sheerun/vim-polyglot'
    " }}}
    
    " Clojure {{{
        " Plug 'guns/vim-clojure-static'
        Plug 'tpope/vim-fireplace'
        
    " }}}
    
    " Rust {{{
        Plug 'rust-lang/rust.vim'
    " }}}


    " Styles {{{
        Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] }
        Plug 'groenewege/vim-less', { 'for': 'less' }
        Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
        Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
        Plug 'gko/vim-coloresque'
        Plug 'stephenway/postcss.vim', { 'for': 'css' }
    " }}}

    " markdown {{{
        Plug 'tpope/vim-markdown', { 'for': 'markdown' }
    " }}}

    " JSON {{{
        Plug 'elzr/vim-json', { 'for': 'json' }
        let g:vim_json_syntax_conceal = 0
    " }}}

    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'timcharper/textile.vim', { 'for': 'textile' }
    " Plug 'lambdatoast/elm.vim', { 'for': 'elm' }
    Plug 'elmcast/elm-vim'
    Plug 'kchmck/vim-coffee-script', { 'for': 'coffeescript' }
    Plug 'nikvdp/ejs-syntax'
" }}}

call plug#end()

" Colorscheme and final setup {{{
    " This call must happen after the plug#end() call to ensure
    " that the colorschemes have been loaded
    " colorscheme japanesque
    set t_Co=256
    " colorscheme inkstained
    colorscheme hydrangea
    " colorscheme vim-monokai-tasty
    " colorscheme seoul256

    syntax on
    filetype plugin indent on
    " make the highlighting of tabs and other non-text less annoying
    highlight SpecialKey ctermfg=19
    highlight NonText ctermfg=19

    " make comments and HTML attributes italic
    highlight Comment cterm=italic
    highlight htmlArg cterm=italic
    highlight xmlAttrib cterm=italic
    highlight Type cterm=italic
    highlight Normal ctermbg=none

" }}}

" vim:set foldmethod=marker foldlevel=0
