Plug 'samsonw/vim-task'
Plug 'terryma/vim-multiple-cursors'
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'christophermca/meta5'
Plug 'nvie/vim-flake8'
Plug 'w0ng/vim-hybrid'
Plug 'tpope/vim-surround'
Plug 'matze/vim-lilypond'
Plug 'tpope/vim-repeat'
Plug 'trevordmiller/nova-vim'
Plug 'chriskempson/base16-vim'
Plug 'vim-autoformat/vim-autoformat'
Plug 'camponez/vim-mediawiki'
Plug 'ledger/vim-ledger'
Plug 'jnurmine/Zenburn'
Plug 'chriskempson/base16-vim'
Plug 'janko-m/vim-test'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'
Plug 'mboughaba/i3config.vim'
Plug 'jceb/vim-orgmode'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'arcticicestudio/nord-vim'
Plug 'glacambre/firenvim'
Plug 'keith/rspec.vim'
Plug 'pangloss/vim-javascript'
Plug 'osyo-manga/vim-over'

Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }

call plug#end()

lua <<EOF
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require('lint').linters_by_ft = {
  python = {'pylint',}
}
