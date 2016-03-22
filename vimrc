set nocompatible
set backup
set history=3000
set ruler
set showcmd
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set incsearch
set hlsearch

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

set softtabstop=4
set shiftwidth=4
set nowrap

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

set exrc
set secure

set listchars=eol:↲,tab:▸·,trail:·,precedes:«,extends:»
set list

set noswapfile

set wildignore=*.swp,*.so,*.pyc,*.class

hi ColorColumn ctermbg=DarkRed guibg=DarkRed
set colorcolumn=100
