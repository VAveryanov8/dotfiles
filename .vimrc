" Pluggins
call plug#begin()
" go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } 
Plug 'SirVer/ultisnips'
Plug 'AndrewRadev/splitjoin.vim'
" Themes
Plug 'fatih/molokai'
Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' }
Plug 'altercation/vim-colors-solarized'
if !has("nvim")
	Plug 'Shougo/neocomplete.vim'
endif
" Plug 'ctrlpvim/ctrlp.vim'

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'jiangmiao/auto-pairs'
" git plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vim-scripts/c.vim'
Plug 'udalov/kotlin-vim'
Plug 'tpope/vim-repeat'
Plug 'yuttie/comfortable-motion.vim'
" markdown
Plug 'JamshedVesuna/vim-markdown-preview'
" Tags
Plug 'majutsushi/tagbar'
" Neovim
if has("nvim")
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'zchee/deoplete-go', { 'do': 'make'}
endif
" Mutlifile replace/ silver searcher
Plug 'wincent/ferret'
" Rest Client
Plug 'quach/vim-http-client'
" Better terminal support
Plug 'wincent/terminus'
Plug 'python-mode/python-mode'
" Indent line
Plug 'yggdroot/indentline'
" JSON
Plug 'elzr/vim-json'
call plug#end()

" Python settings
let g:pymode_rope_completion = 1
let g:pymode_rope_autoimport = 1

" Go settings
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1

autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>i <Plug>(go-info)

" Molokai colorscheme
let g:rehash256 = 1
"let g:molokai_original = 1
"set background=dark
"let g:solarized_termcolors=256
"let g:solarized_visibility="low"
colorscheme jellybeans

" Go info settings
let g:go_auto_type_info = 0
" set updatetime=100

" Go linter settings
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1

" Neocomplete settings
if !has("nvim")
	let g:acp_enableAtStartup = 0
	" Use neocomplete.
	let g:neocomplete#enable_at_startup = 1
	" Use smartcase.
	let g:neocomplete#enable_smart_case = 1
endif

" Vim common settings
set guioptions-=m
set guioptions-=T
set guifont=FiraCode\ Regular\ 10
set number

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.yml setlocal  tabstop=2 sts=2 shiftwidth=2 expandtab
autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 sts=2 shiftwidth=2 expandtab
autocmd BufNewFile,BufRead *.json setlocal tabstop=2 sts=2 shiftwidth=2 expandtab

autocmd BufNewFile,BufRead *.exm,*.hbs setlocal tabstop=2 sts=2 shiftwidth=2 expandtab syntax=json
autocmd BufNewFile,BufRead *.env setlocal tabstop=2 sts=2 shiftwidth=2 expandtab syntax=yaml

" Incsearch plugin setting
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" NerdTree
map <C-n> :NERDTreeToggle<CR>
map <Leader><Leader>r :NERDTreeFind<CR>

" FZF
map <C-p> :FZF<CR>

" Vim Airline
set laststatus=2
let g:airline_theme = 'bubblegum'
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
	" unicode symbols
	"let g:airline_left_sep = '»'
	"let g:airline_left_sep = '▶'
	"let g:airline_right_sep = '«'
	"let g:airline_right_sep = '◀'
	"let g:airline_symbols.crypt = '🔒'
	"let g:airline_symbols.linenr = '␊'
	"let g:airline_symbols.linenr = '␤'
	"let g:airline_symbols.linenr = '¶'
	"let g:airline_symbols.maxlinenr = '☰'
	"let g:airline_symbols.maxlinenr = ''
	"let g:airline_symbols.branch = '⎇'
	"let g:airline_symbols.paste = 'ρ'
	"let g:airline_symbols.paste = 'Þ'
	"let g:airline_symbols.paste = '∥'
	"let g:airline_symbols.spell = 'Ꞩ'
	"let g:airline_symbols.notexists = '∄'
	"let g:airline_symbols.whitespace = 'Ξ'
endfunction
" Smooth scroll 
" let g:comfortable_motion_scroll_down_key = "j"
" let g:comfortable_motion_scroll_up_key = "k"

" Markdown preview
let vim_markdown_preview_perl=1
let vim_markdown_preview_use_xdg_open=1
let vim_markdown_preview_browser='chromium'

if has("nvim")
	nmap <F9> :vsplit term://zsh<CR>
endif

" Tagbar bindings
nmap <F8> :TagbarToggle<CR>

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
