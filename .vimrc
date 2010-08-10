" .vim/bundle を使う
call pathogen#runtime_append_all_bundles()

"{{{ Vim の流儀 より
filetype plugin on
filetype indent on
syntax enable
" from Ubuntu default
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,utf-16,japan

set backspace=2
set tabstop=2
set shiftwidth=4
set expandtab

highlight tabs ctermbg=green guibg=green

set list
set number
set ruler
set smartindent
set laststatus=2

"{{{ 文字コードの自動認識
set fileformats=unix,dos,mac

" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
"}}}

"{{{ PHPManual
" PHP マニュアルを設置している場合
let g:ref_phpmanual_path = $HOME . 'modules/php-5.2.6/lib/php/data/phpman/php-chunked-xhtml/'
let g:ref_phpmanual_cmd = 'w3m -dump %s'
"let phpmanual_dir = $HOME . '/.vim/manual/php_manual_ja/'
" マニュアルの拡張子
"let phpmanual_file_ext = 'html'
" マニュアルのカラー表示
let phpmanual_color = 1
" iconv 変換をしない
let phpmanual_convfilter = ''
" w3m の表示形式を utf-8 にし、auto detect を on にする
let phpmanual_htmlviewer = 'w3m -o display_charset=utf-8 -o auto_detect=2 -T text/html'
" phpmanual.vim を置いているパスを指定
"source $HOME/.vim/ftplugin/phpmanual.vim
"}}}
