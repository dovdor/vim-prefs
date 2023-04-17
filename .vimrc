set nocompatible
set nobackup
set nowritebackup
set history=300
set ruler
set showcmd
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set incsearch
set hlsearch

call plug#begin('~/.vim/plugged')

" Theme gruvbox
Plug 'morhetz/gruvbox'

" ViM git support
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rhubarb'

" fzf setup
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" commenter
Plug 'preservim/nerdcommenter'

" Black
Plug 'psf/black', { 'tag': 'stable' }

" Jinja2
Plug 'glench/vim-jinja2-syntax'

" TF
Plug 'hashivim/vim-terraform'

" vim-ai
Plug 'madox2/vim-ai'
call plug#end()

syntax on
filetype plugin indent on
augroup vimrcEx
au!
autocmd FileType text setlocal textwidth=78
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

augroup END

" Do not use the system clipboard
" set clipboard=unnamed
set softtabstop=4
set shiftwidth=4
set nowrap

set background=dark
colorscheme gruvbox
set printoptions=number:y,duplex:long
set printexpr=system('open\ -a\ Preview\ '.v:fname_in)\ +\ v:shell_error


function! ChangeCurrentDir()
    let _dir_notescaped = expand("%:p:h")
    let _dir = substitute( _dir_notescaped, ' ', '\\ ', 'g' )
    if empty( finddir( _dir, "" ) ) || !isdirectory( _dir )
        return
    endif
    exec "cd " . _dir
    unlet _dir
endfunction

autocmd BufEnter,BufWinEnter * call ChangeCurrentDir()

set visualbell
set cursorline
set completeopt=
set complete-=i
set cinoptions=g0(0:0

" Command-mode completion
" Completes to longest common string then lists opts
set wildmode=longest,list,full

" Spellchecker setup
set spellfile=~/.vimspelladdition.add
set spelllang=en_us

" remap ± and § to ~ and ` respectively
" Using KeyRemap4MacBook/Karabiner
"map! § `
"map! ± ~
"map § `
"map ± ~

" Enable Cscope
set cscopetag
set cscopeverbose
set cscopequickfix=s-,c-,d-,i-,t-,e-
cnoreabbrev csa cs add
cnoreabbrev csf cs find
cnoreabbrev csk cs kill
cnoreabbrev csr cs reset
cnoreabbrev css cs show
cnoreabbrev csh cs help

" Push .class files to the end of the file completion list
set suffixes+=.class

" Always show status line
set laststatus=2
set statusline=%f%r%m\ %{fugitive#statusline()}%=%l/%L\ %c

" Ignore case but allow smartcase
set ignorecase
set smartcase

" noh - ctrl-l
nnoremap <silent> <C-l> :noh<CR>

" allow exrc
set exrc
set secure

set listchars=eol:↲,tab:▸·,trail:·,precedes:«,extends:»
set list

set noswapfile

set wildignore=*.swp,*.so,*.pyc,*.class,*.sublime*

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Disable folding in vim-markdown
let g:vim_markdown_folding_disabled=1

nnoremap <silent> <Leader>md :silent !preview-markdown.sh % /tmp/%.html<CR>

" Set line marker
hi ColorColumn ctermbg=DarkRed guibg=DarkRed
set colorcolumn=100

" automatically reload vimrc when it's saved
au BufWritePost ~/.vimrc so ~/.vimrc

" save changes when :make-ing
set autowrite

" configure netrw
" ctrl-n
map <C-n> :Vexplore<CR>
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" configure line numbers
set relativenumber
set number

" remove syntax coloring for large files
" https://stackoverflow.com/questions/178257/how-to-avoid-syntax-highlighting-for-large-files-in-vim
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

" Tab moves
nnoremap <Leader><Right> gt
nnoremap <Leader><Left> gT

" Black
nnoremap <Leader>b :Black<CR>

" fzf mapping
" ref: https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko
let g:fzf_preview_window = ['up:50%', 'ctrl-/']
nnoremap <silent> <C-p> :Files ~/Projects<CR>
nnoremap <silent> <Leader>f :Rg<CR>
command! -bang -nargs=? PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': '~/Projects'}, <bang>0)

" Silversearcher (https://gist.github.com/grillermo/3e318d224b1ddcf1bafd)
" if executable('ag')
  " " Use ag over grep
  " set grepprg=ag\ --nogroup\ --nocolor
" endif
" Use rg over default grep
" https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case\ --follow
endif

" ref: https://vim.fandom.com/wiki/Copy_filename_to_clipboard
" copy filename, path, folder into clipboard
nmap ,cs :let @*=expand("%")<CR>
nmap ,cl :let @*=expand("%:p")<CR>
nmap ,cp :let @*=expand("%:p:h')<CR>
