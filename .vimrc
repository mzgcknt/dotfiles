filetype plugin indent on

syntax on

set wrap

"インクリメンタルサーチしない
set noincsearch
set hlsearch
set ignorecase
set smartcase

set autoindent

"カーソルに位置表示
set ruler
set number
set list
set listchars=tab:>-,eol:↲,extends:»,precedes:«,nbsp:%

set wildmenu
"入力中のコマンドを表示
set showcmd

"インデント幅
set shiftwidth=4
set softtabstop=4
set tabstop=4
"タブをスペースに変換
set expandtab
set smarttab
set encoding=utf-8

"クリップボードの共有
set clipboard=unnamed,autoselect
set whichwrap=b,h,l,s,[,],<,>

"バックスペースの挙動変更
set backspace=indent,eol,start
set nrformats-=octal

"補完行数
set pumheight=10

"対応する括弧に一瞬移動
set showmatch
set matchtime=1

"長い行も表示
set display=lastline

"アンドゥファイルを作らせない
set noundofile

"~ファイルを作らせない 
set nobackup

""""""""""""""""""""""""""""""
" setup vim-plug
""""""""""""""""""""""""""""""
" :PlugInstall to install plugins
call plug#begin('~/.vim/plugged')

" ファイルオープンを便利に
Plug 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
Plug 'Shougo/neomru.vim'

""""""""""""""""""""""""""""""
" Unit.vim
" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ファイルをtree表示してくれる
Plug 'scrooloose/nerdtree'
" Ruby向けにendを自動挿入してくれる
Plug 'tpope/vim-endwise'
" コメントON/OFFを手軽に実行
Plug 'tomtom/tcomment_vim'
" シングルクオートとダブルクオートの入れ替え cs'" '→" 
Plug 'tpope/vim-surround'
" インデントに色を付けて見やすくする
Plug 'nathanaelkane/vim-indent-guides'
" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1
" ログファイルを色づけしてくれる
Plug 'vim-scripts/AnsiEsc.vim'
" 行末の半角スペースを可視化
Plug 'bronson/vim-trailing-whitespace'
" HTHM,CSSの入力補完
Plug 'mattn/emmet-vim'
call plug#end()
"Yを行末までヤンクに
nnoremap Y y$n
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""
