if has("gui_running")
    set guifont=Meslo\ LG\ L\ DZ\ for\ Powerline\ 13
    set lines=60 columns=82
endif

if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
else
    if $TERM == 'xterm'
        set term=xterm-256color
    endif
endif

if &term =~ '256color'
  set t_ut=
endif

set guicursor=i-ci-ve:ver25

if filereadable(vimplug_exists)
    colorscheme hybrid
endif

set background=dark
let g:hybrid_use_Xresources = 1

filetype on
filetype plugin on


" make this a filetype=mediawiki
map ,m :set filetype=mediawiki<CR>

"save with ctrl-s
map <C-s> :w<CR>

" TODO navegate error list
" map

" plugins configure
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsSnippetsDir=$HOME
let g:UltiSnipsSnippetDirectories=[$HOME.'/Ultisnips', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips']
let g:UltiSnipsUsePythonVersion = 3
let Tlist_Inc_Winwidth=40
let Tlist_Auto_Open = 0
"map <F4> :TlistToggle<cr>

"let g:NERDTreeWinSize = 30

set listchars=tab:»·,trail:·,eol:¶
set tw=79
set colorcolumn=79
set list
set cpoptions+=L
set relativenumber
nnoremap ,d "=strftime("%d/%m/%Y %H:%M:%S")<CR>P
" make word completion to include -
set lisp

augroup php
    autocmd!
    autocmd BufRead,BufNewFile *.php setlocal expandtab foldmethod=marker
                \ foldmarker={,}
augroup END

augroup cpp
    autocmd!
    autocmd BufRead,BufNewFile *.cpp setlocal expandtab foldmethod=marker
                \ foldmarker={,}
    autocmd BufRead,BufNewFile *.h setlocal expandtab foldmethod=marker
                \ foldmarker={,}
augroup END

augroup python
    autocmd!
    autocmd BufRead,BufNewFile *.py setlocal expandtab foldmethod=indent
    autocmd BufWrite *.py :Autoformat|Semshi highlight
augroup END

augroup ruby
    autocmd!
    autocmd BufRead,BufNewFile *.rb setlocal tabstop=2 sw=2 expandtab foldmethod=indent
augroup END

" autocmd BufNewFile,BufRead todo.txt,*.task,*.tasks  set filetype=task
autocmd BufNewFile,BufRead *cruzeiropedia.org.* setlocal ft=mediawiki

autocmd BufWrite *.rb,*.py,*.js,*.sh,*.json :Autoformat

autocmd BufRead,BufNewFile *.at,*.atlib set ft=at

"======================== LEDGER
let g:ledger_maxwidth = 80
let g:ledger_align_at = 46
let g:ledger_fold_blanks = 1
let g:ledger_fillstring = '· '
let g:ledger_default_commodity = 'EUR'
let g:ledger_commodity_sep = ' '
let g:ledger_commodity_before = 0
let g:ledger_date_format = '%Y-%m-%d'
let g:ledger_main = 'main.ledger'
autocmd FileType ledger setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType ledger nmap <F2> :%LedgerAlign<CR><CR>
autocmd FileType ledger nmap <F3> :call ledger#transaction_state_toggle(line('.'), ' *!')<CR>
autocmd FileType ledger nmap <F4> :call ledger#entry()<CR>
autocmd FileType ledger inoremap <silent> <Tab> <C-r>=ledger#autocomplete_and_align()<CR>
autocmd FileType ledger vnoremap <silent> <Tab> :LedgerAlign<CR>

" let g:ledger_extra_options = '--pedantic --explicit --check-payees'



autocmd BufWrite *.rb,*.js,*.py,*.c,*.go,*.json,*.sh :Autoformat
let g:autoformat_autoindent = 0

hi Visual guibg=orange guifg=white
hi ColorColumn guibg=#556873 guifg=white

" python-syntax: Switch on all options
let python_highlight_all = 1
let g:airline_powerline_fonts = 1

let g:syntastic_rst_rst2pseudoxml_quiet_messages = {
            \"type": 'error',
            \"regex": 'Unknown directive type "youtube"'
            \}
let g:syntastic_c_compiler_options = '-std=c++11'
let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_php_phpcs_args='--tab-width=0'
let g:gitgutter_hilight_lines = 1

let g:requirements#detect_filename_pattern = 'cruzeiropedia.org'

let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_python_checkers = ['pylint']

let g:python3_host_prog = $HOME.'/.pyenv/shims/python3'
" let g:python_host_prog = 0
" let g:loaded_python_provider = 0

" ALE
let g:ale_fix_on_save = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0
let g:ale_linters_explicit = 1
let g:ale_linters = {'python': ['pylint', 'autopep8'], 'sh': ['shellcheck']}
let g:ale_fixers = {'python': ['autopep8']}
let g:ale_sign_column_always = 1
let g:ale_set_quickfix = 0
let g:ale_python_pylint_options = "--init-hook='import sys; sys.path.append(\"..\");sys.path.append(\".\");'"

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

let g:PHP_removeCRwhenUnix = 1

let base16colorspace=256  " Access colors present in 256 colorspace"

let g:formatdef_autopep8 = '"autopep8 --aggressive --aggressive -".(g:DoesRangeEqualBuffer(a:firstline, a:lastline) ? " --range ".a:firstline." ".a:lastline : "")." ".(&textwidth ? "--max-line-length=".&textwidth : "")'

" disable menu
set go-=m

set inccommand=split
set wildoptions=pum
set wildmode=longest:full


let g:LanguageClient_serverCommands = {
    \ 'python': [$HOME.'/.pyenv/shims/pyls'],
    \ 'ruby': [$HOME.'/.rvm/gems/ruby-2.6.3/bin/language_server-ruby'],
    \ }

let g:test#python#pytest#executable = 'python -m pytest -v'
let g:test#strategy = 'neovim'

map ,tf :TestFile<CR>
map ,tn :TestNearest<CR>

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

let g:lsp_preview_float = 1
" let g:lsp_log_file= $HOME.'/vim-lsp.log'

let g:python3_host_prog = $HOME.'/.pyenv/shims/python'

function MyCustomHighlights()
    hi semshiSelf      ctermfg=243
endfunction
autocmd FileType python call MyCustomHighlights()
let g:firenvim_config = {
    \ 'localSettings': {
        \ '.*': {
            \ 'selector': '',
            \ 'priority': 0,
        \ },
        \ 'cruzeiropedia\.org': {
            \ 'selector': 'textarea',
            \ 'priority': 1,
        \ },
    \ }
\ }

let g:LanguageClient_loggingFile = $HOME.'/LanguageClient.log'

" let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['Comment', 'String'])
