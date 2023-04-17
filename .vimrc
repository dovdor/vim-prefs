set nocompatible
set backup
set history=300
set ruler
set showcmd
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set incsearch
set hlsearch

" Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

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

" Trying a new thing
" set clipboard=unnamed
set softtabstop=4
set shiftwidth=4
set nowrap

set background=dark
colorscheme solarized
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

" Set Find to find in files
" Disabled: Using csf f for a while
" command! -nargs=1 csff csf f <args>

function! EnableCscopeConnection( project )
    let _cscope_db = "~/Projects/envs/" . a:project . "/db"
    silent exec "cs add " . _cscope_db
    unlet _cscope_db
endfunction

" Push .class files to the end of the file completion list
set suffixes+=.class

" Always show status line
set laststatus=2
set statusline=%f%r%m\ %{fugitive#statusline()}%=%l/%L\ %c

" Ignore case but allow smartcase
set ignorecase
set smartcase

" Cmd-n
map <C-n> :Explore<CR>
nnoremap <silent> <C-l> :noh<CR>
nnoremap <Leader>g :Ag 

set exrc
set secure

set listchars=eol:↲,tab:▸·,trail:·,precedes:«,extends:»
set list

set noswapfile

set wildignore=*.swp,*.so,*.pyc,*.class

" Configure ctrlp
let g:ctrlp_working_path_mode = 'ra'

let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Disable folding in vim-markdown
let g:vim_markdown_folding_disabled=1

nnoremap <silent> <Leader>md :silent !preview-markdown.sh % /tmp/%.html<CR>

hi ColorColumn ctermbg=DarkRed guibg=DarkRed
set colorcolumn=100

" automatically reload vimrc when it's saved
au BufWritePost ~/.vimrc so ~/.vimrc

" save changes when :make-ing
set autowrite
