" Pluggins
call plug#begin()
" go --- {{{
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } 
Plug 'SirVer/ultisnips'
Plug 'AndrewRadev/splitjoin.vim'
" }}}
" themes
Plug 'morhetz/gruvbox'
if !has("nvim")
	Plug 'Shougo/neocomplete.vim'
endif

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
" git plugins --- {{{
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
" }}}

" utils -----{{{
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'dhruvasagar/vim-table-mode'
Plug 'tpope/vim-repeat'
Plug 'yuttie/comfortable-motion.vim'
Plug 'jeetsukumaran/vim-indentwise'
" }}}
" Tags
Plug 'majutsushi/tagbar'
" Neovim
if has("nvim")
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'zchee/deoplete-go', { 'do': 'make'}
endif
" Mutlifile replace/ silver searcher
Plug 'wincent/ferret'
" HTTP Client
Plug 'diepm/vim-rest-console'
" Better terminal support
Plug 'wincent/terminus'
" Indent line
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-obsession'
Plug 'ludovicchabant/vim-gutentags'
" Markdown
Plug 'suan/vim-instant-markdown'
" StartScreen customizer
Plug 'mhinz/vim-startify'
" lsp client
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
call plug#end()

" lsp servers registries --- {{{
" python
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
" c/c++
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif
" ruby
if executable('solargraph')
    " gem install solargraph
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif
" ocaml/reason
if executable('ocaml-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'ocaml-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'opam config exec -- ocaml-language-server --stdio']},
        \ 'whitelist': ['reason', 'ocaml'],
        \ })
endif
" rust
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif
" }}}

" Lsp settings --- {{{
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
" }}}

" Mappings ---------- {{{
inoremap jk <esc>
inoremap <esc> <nop>
inoremap <ctrl>] <nop>

nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

if has("nvim")
	nmap <F9> :vsplit term://zsh<CR>
endif
" NerdTree
nmap <F8> :TagbarToggle<CR>
map <C-n> :NERDTreeToggle<CR>
map <Leader><Leader>r :NERDTreeFind<CR>
" }}}

" Go settings ---- {{{
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
" Go info settings
let g:go_auto_type_info = 0
" set updatetime=100

" Go linter settings
let g:go_metalinter_enabled = ['vet', 'errcheck', 'ineffassign']
let g:go_metalinter_autosave_enabled = ['vet', 'ineffassign']
let g:go_metalinter_autosave = 1

augroup go
	autocmd!
	autocmd!
	autocmd FileType go nmap <leader>r <Plug>(go-run)
	autocmd FileType go nmap <leader>b <Plug>(go-build)
	autocmd FileType go nmap <leader>t <Plug>(go-test)
	autocmd FileType go nmap <Leader>i <Plug>(go-info)
	autocmd FileType go nmap <Leader>ie <Plug>(go-iferr)
	autocmd FileType go nmap <Leader>d :GoDecls<CR>
augroup END

" }}}

let g:rehash256 = 1

colorscheme gruvbox
set background=dark 

function! HandleFASD(dir_name)
	execute "cd " . a:dir_name
	normal :FZF
endfunction

function! BranchDiff(rev)
	let list = map(split(system('git diff --name-status '.a:rev.'..master| grep -o -e \\S\\+$ | grep -v vendor','\n')), '{"filename": v:val}')
	call setqflist(list)
	copen
endfunction

command! FASD call fzf#run(fzf#wrap({'source': 'zsh -c "fasd -dl"', 'options': '--no-sort --tac --tiebreak=index', 'sink': function('HandleFASD')}))
nnoremap <silent> <Leader>f :FASD<CR>

" Neocomplete settings --- {{{
if !has("nvim")
	let g:acp_enableAtStartup = 0
	" Use neocomplete.
	let g:neocomplete#enable_at_startup = 1
	" Use smartcase.
	let g:neocomplete#enable_smart_case = 1
endif
" }}}

" Vim common settings ---- {{{
set guioptions-=m
set guioptions-=T
set number
" }}}

" Vimscript file setting --- {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType vim setlocal foldlevel=0
augroup END
" }}}

augroup localsetting
	autocmd!
	autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
	autocmd BufNewFile,BufRead *.yml setlocal  tabstop=2 sts=2 shiftwidth=2 expandtab
	autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 sts=2 shiftwidth=2 expandtab
	autocmd BufNewFile,BufRead *.json,*.rb setlocal tabstop=2 sts=2 shiftwidth=2 expandtab

	autocmd BufNewFile,BufRead *.exm,*.hbs setlocal tabstop=2 sts=2 shiftwidth=2 expandtab syntax=json
	autocmd BufNewFile,BufRead *.env setlocal tabstop=2 sts=2 shiftwidth=2 expandtab syntax=yaml
augroup END

" Incsearch plugin setting --- {{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
nmap <silent> ./ :nohlsearch<CR>
" }}}


map <C-p> :FZF<CR>

" Vim Airline --- {{{
let g:airline#extensions#obsession#enabled = 1

set laststatus=2
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_theme_patch_func='AirlineThemePatch'
function! AirlineThemePatch(palette)
	let g:airline_symbols.branch = ''
	let g:airline_symbols.readonly = ''
	let g:airline_symbols.linenr = ''
endfunction
" }}}


" json fix for quotes
set conceallevel=0
