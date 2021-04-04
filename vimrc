" vim Kasumiru config 21.01.08
syntax on
color darkblue
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
set t_Co=256
""
"""
""""
"""
"" не подсвечивать поиск
set nohls
" игнорировать регистр при поиске
set ic
""""
""""
set wildmenu
set wcm=<Tab>
menu Exec.GForth  :!gforth % <CR>
menu Exec.Perl    :!perl % <CR>
menu Exec.Python  :!python % <CR>
menu Exec.Ruby    :!ruby % <CR>
menu Exec.bash      :!/bin/bash<CR>
menu Exec.xterm     :!xterm<CR>
menu Exec.mc        :!mc<CR>
menu Exec.xterm_mc  :!xterm -e mc<CR>
map <F9> :emenu Exec.<Tab>
"""
"""
"""" Work not in centos 7, vim 7.4:
"""" автодополнение текста по табу
"function! InsertTabWrapper(direction)
"   let col = col('.') - 1
"   if !col || getline('.')[col - 1] !~ '\k'
"       return "\<tab>"
"   elseif "backward" == a:direction
"       return "\<c-p>"
"   else
"       return "\<c-n>"
"   endif
"endfunction
"inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
"inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>
"""
"""
""""
"""" Что бы в русской раскладке работали сочетания клавиш
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
"""
"""
""""
""""
set keymap=russian-jcukenwin    " настраиваем переключение раскладок клавиатуры по C-^
set iminsert=0                  " раскладка по умолчанию для ввода - английская
set imsearch=0                  " раскладка по умолчанию для поиска - английская
" переключение на русскую/английскую раскладку по ^f (Ctrl + F)
cmap <silent> <C-F> <C-^>
imap <silent> <C-F> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
nmap <silent> <C-F> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
vmap <silent> <C-F> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv
" Переключение раскладок и индикация выбранной в данный момент раскладки -->
" При английской раскладке статусная строка текущего окна будет синего цвета, а при русской - красного
function MyKeyMapHighlight()
        if &iminsert == 0
        hi StatusLine ctermfg=DarkBlue guifg=DarkBlue
    else
        hi StatusLine ctermfg=DarkRed guifg=DarkRed
    endif
endfunction
" Вызываем функцию, чтобы она установила цвета при запуске Vim'a
call MyKeyMapHighlight()
" При изменении активного окна будет выполняться обновление индикации текущей раскладки
au WinEnter * :call MyKeyMapHighlight()
" <--
"


"nnoremap <c-d> <c-r>
"inoremap <c-d> <c-r>

" запуск в bash
nnoremap <c-a> <esc>:w<enter>:!/bin/bash %:p<enter>
inoremap <c-a> <esc>:w<enter>:!/bin/bash %:p<enter>
" запуск в python3
nnoremap <c-d> <esc>:w<enter>:!/usr/bin/env python3 %:p<enter>
inoremap <c-d> <esc>:w<enter>:!/usr/bin/env python3 %:p<enter>




" плавная построчная прокрутка на ctrl e && ctrl w
nnoremap <c-w> <c-y>
inoremap <c-w> <c-y>
nnoremap <c-e> <c-e>
inoremap <c-e> <c-e>

" сохранить на ctrl s 
nnoremap <c-s> <esc>:w<enter>
inoremap <c-s> <esc>:w<enter>
"""

" рестарт nginx
nnoremap <c-n> <esc>:w<enter>:!nginx -t && nginx -s reload<enter>
inoremap <c-n> <esc>:w<enter>:!nginx -t && nginx -s reload<enter>


""" следующий блок будет при открытии документа переносить на старую позицию
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
"""
"""
set mouse -=a
"""
"""
""" При нажатии f6 можно увидеть hex содержимое фала
noremap <F6> :call HexMe()<CR>
let $in_hex=0
function HexMe()
set binary
set noeol

if $in_hex>0
:%!xxd -r
let $in_hex=0
else
:%!xxd
let $in_hex=1
endif
endfunction
"""
"""
"""
""" При нажатии HEX можно увидеть hex содержимое фала
noremap HEX :call HexMe2()<CR>
let $in_hex=0
function HexMe2()
set binary
set noeol

if $in_hex>0
:%!xxd -r
let $in_hex=0
else
:%!xxd
let $in_hex=1
endif
endfunction
let g:loaded_matchparen=1
""
" bind "\l" to show ALL hidden symbols
nmap <leader>l :set list!<CR>
""
"" замена символа конца строки $ на символ ¬
""set listchars=tab:▸\ ,eol:¬
" Если в вашей цветовой теме спецсимволы отображаются не тем цветом как вам бы хотелось. Исправить это можно через ключи NonText и SpecialKey, команды hightlight. from http://dev-mark.blogspot.com/2010/11/vim.html#:~:text=%D0%92%20Vim%60%D0%B5%20%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%20%D0%B2%D0%BA%D0%BB%D1%8E%D1%87%D0%B8%D1%82%D1%8C,nolist%20%D0%B8%D0%BB%D0%B8%20%3Aset%20list!.
"Invisible character colors 
highlight NonText guifg=#4a4a29
highlight SpecialKey guifg=#4a4a29
""
""
""
"" плавная прокрутка построчная shift + up\down
nnoremap <S-Up> <c-y>
nnoremap <S-DOwn> <c-e>
""
""
""
"""""""""""""""""""
" поиск по сову под курсором назад
nnoremap <S-e> *
" поиск по сову под курсором вперёд
"Press * to search for the next occurrence
nnoremap <S-q> #
"""""""""""""""""""
""
""
"""
""""""""
""""""""
"""
" disable swap files
set noswapfile
" Alternatively, store your swap files in your local .vim folder
" call system('mkdir ~/.vim/swap')
" set dir=~/.vim/swap/

if has('persistent_undo')
  set undolevels=5000
  call system('mkdir ~/.vim/undo')
  set undodir=~/.vim/undo
  set undofile
endif

call system('mkdir ~/.vim/')
call system('mkdir ~/.vim/backups')
set backupdir=~/.vim/backups/

" The 'n' here is a prefix specifying which viminfo property is being set -
" in this case, the Name of the viminfo file.
" :h 'viminfo'
set viminfo+=n~/.vim/viminfo
"""
""""""""
""""""""
"""
" включит 'курсор всегда посередине', текст будет сам прокручитьваться за курсором.
noremap * *N:set hlsearch<Enter> 
" отключит автоматическое перепрыгивание когда ты даже не дописал текст до конца в cygwin
set noincsearch
"
"
"
"
"The 'scrolloff' (scroll offset) option determines the number of context lines you would like to see above and below the cursor. The following command scrolls the text so that (when possible) there are always at least five lines visible above the cursor, and five lines visible below the cursor:
set scrolloff=5
"
" cursor always on center of screen:
"set scrolloff=5 
"
"
