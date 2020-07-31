call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-commentary'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'

" IDE
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Language specific
Plug 'rust-lang/rust.vim'
Plug 'mboughaba/i3config.vim'
Plug 'hashivim/vim-terraform'
Plug 'cespare/vim-toml'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jvirtanen/vim-hcl'

" Color Scheme
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
call plug#end()

" Config
set cmdheight=2
set completeopt=noinsert,menuone,noselect
set cursorline
set expandtab
set hidden
set ignorecase
set incsearch
set mouse=""
set number
set relativenumber
set scrolloff=50
set shiftwidth=4
set shortmess+=c
set signcolumn=yes
set smartcase
set softtabstop=0
set spelllang=en_gb
set splitbelow
set splitright
set tabstop=4
{% if theme_name == 'gruvbox' %}
set termguicolors
{% endif %}
set updatetime=300
set wildignore=.git/*,.venv/*

syntax on
colorscheme {{ theme_name }}

let mapleader = ','
let g:airline_powerline_fonts = 1
let g:airline_theme = '{{ theme_name }}'
let g:airline#extensions#ale#enabled = 1

let g:ale_set_highlights = 0
let g:ale_rust_cargo_use_check = 1

let g:coc_global_extensions = []
let g:coc_global_extensions += ['coc-json']
let g:coc_global_extensions += ['coc-rust-analyzer']
let g:coc_global_extensions += ['coc-yaml']
let g:coc_global_extensions += ['coc-eslint']
let g:coc_global_extensions += ['coc-prettier']
let g:coc_global_extensions += ['coc-sql']
let g:coc_global_extensions += ['coc-tsserver']

{% if is_work | default(false) %}
" Work specific
let g:coc_global_extensions += ['coc-omnisharp']
{% endif %}


let g:fzf_action = {
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = {'window': { 'width': 1, 'height': 1, 'highlight': 'Normal', 'border': 'sharp' } }
let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"

let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 55

let g:terraform_fmt_on_save = 1

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    let g:fzf_tags_command = 'rg --files | ctags --links=no -R -L-'
endif

" Functions
function! RemoveTrailingWhiteSpace()
    :normal mw
    :%s/\s\+$//e
    :normal `w
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

source {{ user.home }}/.config/nvim/include/rnr.vim

" Autocommands
autocmd FileType make setlocal noexpandtab
autocmd FileType yaml,hcl setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.j2 set ft=jinja
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
autocmd BufWritePre * call RemoveTrailingWhiteSpace()

augroup rust
    autocmd! rust
    autocmd FileType rust nnoremap <buffer> <leader>ca :!cargo add<Space>
    autocmd FileType rust nnoremap <buffer> <leader>cc :call RnrExec("cargo clippy")<CR>
    autocmd FileType rust nnoremap <buffer> <leader>ct :call RnrExec("cargo test")<CR>
    autocmd FileType rust nnoremap <buffer> <leader>cr :call RnrExec("cargo run")<CR>
augroup END

" Abbreviations
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qa! qa!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Qall qall

" Key bindings
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <C-P> <Esc>:Files<CR>
inoremap <A-t> <Esc>:call RnrTermToggle()<CR>
inoremap {<cr> {<cr>}<Esc>O

nnoremap <A-t> :call RnrTermToggle()<CR>
nnoremap <esc> :noh<CR><esc>
nnoremap <leader>w :w<CR>
nnoremap <C-P> :Files<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <leader>+t :Tags<CR>
nnoremap ; :Buffers<CR>
nnoremap n nzzzv
nnoremap <leader>\ :NERDTreeToggle<CR>
nnoremap <leader>bc :%bd\|e#<CR>
nnoremap <leader>gy :Goyo 50%<cr>
nnoremap <leader>ss :set spell!<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <leader>rn <Plug>(coc-rename)

vnoremap > >gv
vnoremap < <gv
vnoremap <leader>f y:Rg<Space><C-R>0<CR>
vnoremap <leader>r y:exe<Space>"vimgrep<Space>/".escape(@@, '.')."/<Space>**/*"<CR>:exe<Space>"cdo<Space>s/".escape(@@, '.')."//c<Space>\|<Space>update"<left><left><left><left><left><left><left><left><left><left><left><left>
