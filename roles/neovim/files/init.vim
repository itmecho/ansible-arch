call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'

" IDE
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'dense-analysis/ale'

" Language specific
Plug 'OmniSharp/omnisharp-vim'
Plug 'rust-lang/rust.vim'
Plug 'mboughaba/i3config.vim'
Plug 'jvirtanen/vim-hcl'

" Color Scheme
Plug 'morhetz/gruvbox'
call plug#end()

" Config
set cmdheight=2
set completeopt=noinsert,menuone,noselect
set expandtab
set hidden
set ignorecase
set incsearch
set mouse=""
set number
set relativenumber
set scrolloff=50
set shiftwidth=4
set signcolumn=yes
set smartcase
set softtabstop=0
set splitbelow
set tabstop=4
set termguicolors
set wildignore=.git/*,.venv/*

syntax on
colorscheme gruvbox

let mapleader = ','
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'
let g:airline#extensions#ale#enabled = 1
let g:ale_set_highlights = 0
let g:ale_rust_cargo_use_check = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ }
let g:LanguageClient_diagnosticsEnable = 0

let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 55

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    let g:fzf_tags_command = 'rg --files | ctags --links=no -R -L-'
endif

" Autocommands
autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd FileType rust
    \ autocmd BufWritePre <buffer> :call LanguageClient#textDocument_formatting()
autocmd FileType make setlocal noexpandtab
autocmd FileType yaml,hcl setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

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
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <C-P> <Esc>:Files<CR>

vnoremap > >gv
vnoremap < <gv

nnoremap <esc> :noh<CR><esc>
nnoremap <leader>w :w<CR>
nnoremap <C-P> :Files<CR>
nnoremap <leader>+t :Tags<CR>
nnoremap ; :Buffers<CR>
nnoremap n nzzzv
nnoremap <leader>\ :NERDTreeToggle<CR>
nnoremap <leader>bc :%bd\|e#<CR>
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

vnoremap <leader>f y:exe<Space>"grep<Space>-Ir<Space>".escape(@@, '/')."<Space>*"<CR><CR>
vnoremap <leader>r y:exe<Space>"vimgrep<Space>/".escape(@@, '.')."/<Space>**/*"<CR>:exe<Space>"cdo<Space>s/".escape(@@, '.')."//c<Space>\|<Space>update"<left><left><left><left><left><left><left><left><left><left><left><left>
