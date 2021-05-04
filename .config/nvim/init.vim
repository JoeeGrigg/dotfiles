""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'brooth/far.vim'
Plug 'coot/cmdalias_vim'
Plug 'coot/CRDispatcher'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dense-analysis/ale'
Plug 'djoshea/vim-autoread'
Plug 'fatih/vim-go'
Plug 'hashivim/vim-terraform'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'jvirtanen/vim-hcl'
Plug 'leafgarland/typescript-vim'
Plug 'majutsushi/tagbar'
Plug 'mechatroner/rainbow_csv'
Plug 'morhetz/gruvbox'
Plug 'peitalin/vim-jsx-typescript'
Plug 'posva/vim-vue'
Plug 'rhysd/git-messenger.vim'
Plug 'rhysd/vim-crystal'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sodapopcan/vim-twiggy'
Plug 'terryma/vim-multiple-cursors'
Plug 'towolf/vim-helm'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'zivyangll/git-blame.vim'

call plug#end()

let g:gitgutter_preview_win_floating = 'true'

" ALE
let g:ale_linters = {'ruby': ['rubocop'], 'go': ['gofmt', 'golint', 'go vet', 'gopls']}
let g:alw_linters_explicit = 1
let g:airline#extensions#ale#enabled = 1

"CMD Alias
function! ConfirmQuit(writeFile)
    if (a:writeFile)
        if (expand('%:t')=="")
            echo "Can't save a file with no name."
            return
        endif
        :write
    endif

    if (winnr('$')==1 && tabpagenr('$')==1)
        if (confirm("Do you really want to quit?", "&Yes\n&No", 2)==1)
            :quit
        endif
    else
        :quit
    endif
endfunction
if has("autocmd")
  augroup VIMRC_aliases
    au!
    au VimEnter * CmdAlias wqu\%[it] write|quit
    au VimEnter * CmdAlias q         call\ ConfirmQuit(0)
    au VimEnter * CmdAlias wq        call\ ConfirmQuit(1)
    " au VimEnter * CmdAlias q         echo\ "Use\ :qu[it]\ instead\ of\ :q"
    " au VimEnter * CmdAlias q!        echo\ "Use\ :qu[it]!\ instead\ of\ :q!"
    " au VimEnter * CmdAlias wq        echo\ "Use\ :wqu[it]\ instead\ of\ :wq"
  augroup END
endif

" Deoplete
let g:deoplete#enable_at_startup = 1
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" Fugitive
function! ToggleGStatus()
  if buflisted(bufname('.git/index'))
    bd .git/index
  else
    vertical Gstatus
  endif
endfunction
command ToggleGStatus :call ToggleGStatus()
nmap <silent> <F3> :ToggleGStatus<CR>

" Far
let g:far#default_file_mask = '.'
let g:far#source = 'agnvim'
let g:far#enable_undo=1
"let g:far#ignore_files = '*/node_modules/*'
" set wildignore+=*/node_modules/*

" NERDTree
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=0
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$', '\.swp$', '\.git$', '\.hg', '\.svn', '\.bzr', '\.sass-cache']
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1
nmap <silent> <C-D> :NERDTreeToggle<CR>
nmap <silent> <F1> :NERDTreeToggle<CR>
" let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''

" Helm
autocmd BufRead,BufNewFile */templates/*.yml,*/templates/*.yaml,*/templates/*.tpl set ft=helm

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Mouse Mode
set mouse=a

" Indentation
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set backspace=2

" Wrapping
set nowrap

" Update Time
set updatetime=100

" Enable Undercurl
let &t_Cs = "\e[6m"
let &t_Ce = "\e[24m"

" Theme
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
colorscheme onedark

highlight ALEWarning gui=undercurl guisp=orange term=undercurl cterm=undercurl
highlight ALEError gui=undercurl guisp=red term=undercurl cterm=undercurl

" Clear search highlight onchange to insert mode
autocmd InsertEnter * :let @/=""
