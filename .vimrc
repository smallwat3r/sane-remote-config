syntax on
filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8
set hidden
set nomodeline
set showmatch
set incsearch
set hlsearch
set ignorecase
set scrolljump=8
set nocompatible
set wildignorecase
set noshowmode
set nocursorcolumn
set nocursorline
set shortmess+=c
set nolist
set diffopt+=vertical
set visualbell t_vb=
set foldmethod=marker
set synmaxcol=500
set clipboard+=unnamedplus
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set noswapfile
set nobackup
set undolevels=4000
set undoreload=100000
set undofile
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

function! TrimTrailingWS()
  if exists('b:noStripWhitespace')
    return
  endif
  if search('\s\+$', 'cnw')
    :%s/\s\+$//g
  endif
endfunction

augroup trim_whitespaces
  au!
  au BufWritePre * :call TrimTrailingWS()
augroup END

augroup filetype_detect
  au!
  au BufRead,BufNewFile *.md                      setf markdown
  au BufRead,BufNewFile */nginx/*.conf            setf nginx
  au BufRead,BufNewFile */nginx/**/*.conf         setf nginx
  au BufRead,BufNewFile *.{yaml,yml}              setf yaml
  au BufRead,BufNewFile gitconfig                 setf gitconfig
  au BufRead,BufNewFile Dockerfile.*              setf dockerfile
  au BufRead,BufNewFile *.{dockerfile,Dockerfile} setf dockerfile
  au BufRead,BufNewFile *.log                     setf log
augroup END

augroup filetype_indentation
  au!
  au FileType make   setl ts=8 sw=8 noet
  au FileType go     setl ts=8 sw=8 noet
  au FileType python setl ts=4 sw=4 sts=4 et
  au FileType perl   setl ts=4 sw=4 sts=4 et
augroup END

augroup filetype_specifics
  au!
  au FileType gitcommit setl spell
  au FileType markdown  setl spell list cc=70 | let b:noStripWhitespace=1
  au FileType netrw     setl bh=delete
  au FileType text      setl cc=70
augroup END

let g:netrw_banner        = 0
let g:netrw_sort_sequence = '[\/]$,*'
let g:netrw_localrmdir    = 'rm -r'

let g:pyindent_open_paren   = '0'
let g:pyindent_nested_paren = '&sw'
let g:pyindent_continue     = '&sw'

augroup disable_comment_auto_insert
  au!
  au FileType * setlocal formatoptions-=cro
augroup END

nmap B ^
nmap E $
nmap <silent><space>bd :bp\|bd #<cr>:echo 'Buffer deleted'<cr>
nmap ;w :w<cr>
nmap <space>ws :sp<cr>
nmap <space>wv :vs<cr>
xmap > >gv
xmap < <gv
imap jk <esc>

let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"

function! DefaultColors() abort
  if &diff
    syntax off
  endif

  hi CursorLineNR ctermbg=NONE
  hi Comment      cterm=italic
  hi DiffAdd      ctermfg=255  ctermbg=64
  hi DiffChange   ctermfg=204  ctermbg=NONE cterm=NONE
  hi DiffDelete   ctermfg=9    ctermbg=NONE cterm=NONE
  hi DiffText     ctermfg=255  ctermbg=31
  hi Directory    ctermbg=NONE
  hi EndOfBuffer  ctermbg=NONE
  hi IncSearch    ctermfg=232  ctermbg=229  cterm=bold
  hi LineNr       ctermfg=239  ctermbg=NONE
  hi MatchParen   ctermfg=203  ctermbg=190
  hi NonText      ctermfg=202  ctermbg=NONE
  hi Normal       ctermbg=NONE
  hi Pmenu        ctermfg=242  ctermbg=235
  hi PmenuSel     ctermfg=254  ctermbg=242
  hi Search       ctermfg=232  ctermbg=11   cterm=NONE
  hi SignColumn   ctermbg=NONE
  hi SpellBad     ctermfg=88   ctermbg=210
  hi SpellCap     ctermbg=159  ctermfg=17
  hi StatuslineNC ctermfg=242  ctermbg=NONE cterm=underline
  hi Todo         ctermbg=NONE ctermfg=120
  hi VertSplit    ctermfg=242  ctermbg=NONE cterm=NONE
  hi Visual       cterm=reverse
endfunction

colo desert

augroup custom_colors
  au!
  au ColorScheme * call DefaultColors()
augroup END
