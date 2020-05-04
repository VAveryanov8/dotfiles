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
Plug 'MattesGroeger/vim-bookmarks'
" }}}
" Tags
Plug 'majutsushi/tagbar'
" Neovim
if has("nvim")
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'zchee/deoplete-go', { 'do': 'make'}
endif

Plug 'Shougo/echodoc.vim'
" Mutlifile replace/ silver searcher
Plug 'wincent/ferret'
" Better terminal support
Plug 'wincent/terminus'
" Indent line
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ludovicchabant/vim-gutentags'
" StartScreen customizer
Plug 'mhinz/vim-startify'
" lsp client
" Terrform
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
call plug#end()

" echodoc.vim setting --- {{{
set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
" }}}

" lsp servers registries --- {{{
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'python': ['pyls'],
    \ 'ruby': ['solargraph', 'stdio'],
    \ 'cpp': ['clangd'],
    \ 'c': ['clangd'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'java': ['/usr/local/bin/jdtls', '-data', getcwd()],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'groovy': ['/usr/local/bin/groovy_lsp']
    \ }
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

" FZF --- {{{ 

function! HandleFASD(dir_name)
	execute "cd " . a:dir_name
	normal :FZF
endfunction

function! BranchDiff(rev)
	let list = map(split(system('git diff --name-status '.a:rev.'..master| grep -o -e \\S\\+$ | grep -v vendor','\n')), '{"filename": v:val}')
	call setqflist(list)
	copen
endfunction


augroup fzf
	au!
	au FileType fzf set laststatus=0 noshowmode noruler
	\| au BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

command! FASD call fzf#run(fzf#wrap({'source': 'zsh -c "fasd -dl"', 'options': '--no-sort --tac --tiebreak=index', 'sink': function('HandleFASD')}))
command! MruFasd call fzf#run(fzf#wrap({'source': 'zsh -c "fasd -fl"', 'options': '--no-sort --tac --tiebreak=index', 'sink': 'e'}))

nnoremap <silent> <Leader>fd :FASD<CR>
nnoremap <silent> <Leader>ff :MruFasd<CR>
map <C-p> :FZF<CR>
map <C-s> :Buffers<CR>
" --- }}}

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

" Local File settings ---- {{{
augroup localsetting
	autocmd!
	autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
	autocmd BufNewFile,BufRead *.zig setlocal  tabstop=4 shiftwidth=4 expandtab
	autocmd BufNewFile,BufRead *.yml setlocal  tabstop=2 sts=2 shiftwidth=2 expandtab
	autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 sts=2 shiftwidth=2 expandtab
	autocmd BufNewFile,BufRead *.json,*.rb,*.nim setlocal tabstop=2 sts=2 shiftwidth=2 expandtab

	autocmd BufNewFile,BufRead *.exm,*.hbs setlocal tabstop=2 sts=2 shiftwidth=2 expandtab syntax=json
	autocmd BufNewFile,BufRead *.env setlocal tabstop=2 sts=2 shiftwidth=2 expandtab syntax=yaml
augroup END
" --- }}}

" Incsearch plugin setting --- {{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
nmap <silent> ./ :nohlsearch<CR>
" }}}



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

let g:bookmark_annotation_sign = ''
" json fix for quotes
set conceallevel=0

augroup vimsync
	autocmd!
	autocmd BufWritePost ~/work/vimsync/*.todo call system(expand('~/work/vimsync/vimsync --log 1 ' . bufname("%")))
augroup END

function! Translate()
	" backup register data
	let reg ='"' 
	let reg_save = getreg(reg)
	let reg_type = getregtype(reg)
	silent execute 'norm! gv"'.reg.'y'
	let res = system("trans en:ru -brief ", shellescape(@"))
	vsplit __Translate_Result__
	normal! ggdG
	call append(0, res)
	" restore register
	call setreg(reg, reg_save, reg_type)
endfunction

vnoremap <silent> T :<C-U>call Translate()<CR>
