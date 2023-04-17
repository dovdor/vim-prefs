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

" noh - ctrl-l
nnoremap <silent> <C-l> :noh<CR>

" allow exrc
set exrc
set secure

set listchars=eol:↲,tab:▸·,trail:·,precedes:«,extends:»
set list

set noswapfile

set wildignore=*.swp,*.so,*.pyc,*.class,*.sublime*

" Configure ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:30'
" if !empty($PROJECT_ROOT)
	" let g:ctrlp_working_path_mode = 0
	" nnoremap <Leader>p :<C-U>CtrlP $PROJECT_ROOT<CR>
" else
	" let g:ctrlp_working_path_mode = 'ra'
" endif

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Silversearcher (https://gist.github.com/grillermo/3e318d224b1ddcf1bafd)
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Disable folding in vim-markdown
let g:vim_markdown_folding_disabled=1

nnoremap <silent> <Leader>md :silent !preview-markdown.sh % /tmp/%.html<CR>

hi ColorColumn ctermbg=DarkRed guibg=DarkRed
set colorcolumn=100

" automatically reload vimrc when it's saved
au BufWritePost ~/.vimrc so ~/.vimrc

" save changes when :make-ing
set autowrite

" configure netrw
" ctrl-n
map <C-n> :Explore<CR>
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 1
let g:netrw_altv = 1
let g:netrw_winsize = 25

" configure line numbers
set relativenumber
set number

" remove syntax coloring for large files
" https://stackoverflow.com/questions/178257/how-to-avoid-syntax-highlighting-for-large-files-in-vim
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif
