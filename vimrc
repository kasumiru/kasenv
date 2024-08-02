" vim Kasumiru config 2023.10.23

""" Включение подсветки:
syntax on
""""

""" ===== LOCALE SETTINGS =====
set encoding=utf-8
""""



""" Установка цветовой схемы
color darkblue
""""


""" fix vim shit mouse selected.
set mouse -=a
""""


""" Фикс внешнего вида курсора (в cygwin и не только)
""" ViM block cursor under screen from https://sourceware.org/legacy-ml/cygwin/2013-03/msg00027.html
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
set t_Co=256
""""


""" не подсвечивать поиск
set nohls
""""


""" игнорировать регистр при поиске
set ic
""""


""" Просто пример меню по хоткею F8
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
map <F8> :emenu Exec.<Tab>
""""


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
""""


""" Что бы в русской раскладке работали сочетания клавиш
""" переключение на русскую/английскую раскладку по ^f (Ctrl + F)
"// set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
"// set keymap=russian-jcukenwin    " настраиваем переключение раскладок клавиатуры по C-^
"// set iminsert=0                  " раскладка по умолчанию для ввода - английская
"// set imsearch=0                  " раскладка по умолчанию для поиска - английская
"// cmap <silent> <C-F> <C-^>
"// imap <silent> <C-F> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
"// nmap <silent> <C-F> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
"// vmap <silent> <C-F> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv
"// " Переключение раскладок и индикация выбранной в данный момент раскладки -->
"// " При английской раскладке статусная строка текущего окна будет синего цвета, а при русской - красного
"// function MyKeyMapHighlight()
"//         if &iminsert == 0
"//         hi StatusLine ctermfg=DarkBlue guifg=DarkBlue
"//     else
"//         hi StatusLine ctermfg=DarkRed guifg=DarkRed
"//     endif
"// endfunction
"// " Вызываем функцию, чтобы она установила цвета при запуске Vim'a
"// call MyKeyMapHighlight()
"// " При изменении активного окна будет выполняться обновление индикации текущей раскладки
"// au WinEnter * :call MyKeyMapHighlight()
"// " <--
"// "


"""
" запуск в bash
nnoremap <c-a> <esc>:w<enter>:!/bin/bash %:p<enter>
inoremap <c-a> <esc>:w<enter>:!/bin/bash %:p<enter>
" Run in python:
" nnoremap <c-d> <esc>:w<enter>:!/usr/bin/python3 %:p<enter>
" inoremap <c-d> <esc>:w<enter>:!/usr/bin/python3 %:p<enter>
nnoremap <c-d> <esc>:w<enter>:!/usr/bin/env python3 %:p<enter>
inoremap <c-d> <esc>:w<enter>:!/usr/bin/env python3 %:p<enter>
" Run in Windows python:
"nnoremap <c-d> <esc>:w<enter>:!/cygdrive/c/python/python3 $(/usr/bin/cygpath -w "%:p")<enter>
"inoremap <c-d> <esc>:w<enter>:!/cygdrive/c/python/python3 $(/usr/bin/cygpath -w "%:p")<enter>
" запуск в ansible on specified server
"nnoremap <c-x> <esc>:w<enter>:!/usr/bin/env ansible-playbook %:p<enter>
"inoremap <c-x> <esc>:w<enter>:!/usr/bin/env ansible-playbook %:p<enter>
nnoremap <c-x> <esc>:w<enter>:!/usr/bin/env ansible-playbook -i ami-new.amazon, %:p<enter>
inoremap <c-x> <esc>:w<enter>:!/usr/bin/env ansible-playbook -i ami-new.amazon, %:p<enter>
" запуск в terraform "
"nnoremap <c-g><c-h> <esc>:w<enter>:!bash -c 'terraform apply'<enter>
"inoremap <c-g><c-h> <esc>:w<enter>:!bash -c 'terraform apply'<enter>
"map <c-g>  :!sh -xc 'git commit -a -m "test"'
"map <c-g>  :!sh -xc ''terraform apply || terraform init'
"" запуск в terraform """""""""
nnoremap <c-g><c-g><c-g><c-g><c-g><c-g> <esc>:w<enter>:!unset AWS_ACCESS_KEY; unset AWS_SECRET_KEY; terraform apply <enter>
inoremap <c-g><c-g><c-g><c-g><c-g><c-g> <esc>:w<enter>:!terraform apply <enter>
"" запуск в terraform """""""""
nnoremap <c-i><c-i><c-i><c-i><c-i><c-i> <esc>:w<enter>:!terraform init <enter>
inoremap <c-i><c-i><c-i><c-i><c-i><c-i> <esc>:w<enter>:!terraform init <enter>
""""


""" При нажатии f6 можно увидеть hex содержимое файла
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
let g:loaded_matchparen=1
""""


""" замена символа конца строки $ на символ ¬ да и настройка других невидимых символов:
"set listchars=tab:▸\ ,eol:¬
"set listchars=tab:▸·,eol:¬,precedes:«,extends:»,trail:·",
"set listchars=tab:»·,eol:↲,nbsp:␣,extends:…,space:␣,precedes:<,extends:>,trail:·
"set listchars=tab:»·,eol:¬,nbsp:␣,extends:…,space:␣,precedes:<,extends:>,trail:·
" в зависимости от версии vim сработает или нет изменение невидимых символов:
if has("patch-7.4.710")
    set listchars=tab:»·,eol:¬,nbsp:␣,extends:…,space:…,precedes:«,extends:»,trail:·
else
    set listchars=tab:»·,eol:¬,nbsp:␣,extends:…,precedes:«,extends:»,trail:·
endif
""""


""" Сменить символу переноса строки цвет:
hi NonText ctermfg=8 guifg=gray
""""


""" назначить на "\l" - Показать невидимые символы
""" bind "\l" to show ALL hidden symbols
nmap <leader>l :set list!<CR>
""""

""" назначить на "ctrl + l" - Показать невидимые символы
""" bind "ctrl + l" to show ALL hidden symbols
nnoremap <c-l> <esc>:set list!<CR>
inoremap <c-l> <esc>:set list!<CR>
""""


""" Если в вашей цветовой теме спецсимволы отображаются не тем цветом как вам бы хотелось. Исправить это можно через ключи NonText и SpecialKey, команды hightlight. from http://dev-mark.blogspot.com/2010/11/vim.html#:~:text=%D0%92%20Vim%60%D0%B5%20%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%20%D0%B2%D0%BA%D0%BB%D1%8E%D1%87%D0%B8%D1%82%D1%8C,nolist%20%D0%B8%D0%BB%D0%B8%20%3Aset%20list!.
"Invisible character colors
highlight NonText guifg=#4a4a29
highlight SpecialKey guifg=#4a4a29
""""


""" Переназначить клавишу Ladder:
""" Обычно <leader> назначена клавиша \, но её можно изменить с помощь команды: let mapleader = "ваша_клавиша"
"let mapleader = "ваша_клавиша"
""""


""" disable swap files
set noswapfile
" Alternatively, store your swap files in your local .vim folder
" call system('mkdir ~/.vim/swap')
" set dir=~/.vim/swap/
""""


"""
if has('persistent_undo')
  set undolevels=5000
  call system('mkdir ~/.vim/undo')
  set undodir=~/.vim/undo
  set undofile
endif

call system('mkdir ~/.vim/')
call system('mkdir ~/.vim/backups')
call system('mkdir ~/.vim/undo')
set backupdir=~/.vim/backups/
""""


""" The 'n' here is a prefix specifying which viminfo property is being set -
""" in this case, the Name of the viminfo file.
""" :h 'viminfo'
set viminfo+=n~/.vim/viminfo
""""


""" отключит автоматическое перепрыгивание поиска когда ты даже не дописал текст до конца в cygwin
set noincsearch
""""


""" Включается прокрутка при приближении курсора к нижнему\верхнему краю экрана
""" The 'scrolloff' (scroll offset) option determines the number of context lines you would like to see above and below the cursor. The following command scrolls the text so that (when possible) there are always at least five lines visible above the cursor, and five lines visible below the cursor:
set scrolloff=3
""" включит 'курсор всегда посередине', текст будет сам прокручитьваться за курсором.
noremap * *N:set hlsearch<Enter>
""""


""" Improve vim macro timedout. improve vim hotkey speed timedout
""" Ускорение горячих клавиш
"let g:better_escape_interval = 1
set timeout timeoutlen=500 ttimeoutlen=500
set timeoutlen=9000
set ttimeoutlen=100
""""


""" Disable continuation of comments to the next line in Vim. Сука, слов нет как это бесило. нахер сделано автодобавление комментария с новой строки
au FileType * set fo-=c fo-=r fo-=o
""""


""" двигать выделенные строки:
""" И двигать отступы (indent): выделить строку и shift+>> || shift+<<
""" !!! ПОДВИНУТЬ НАЛЕВО: выделяем строки нажимаем shift+< и далее несколько раз нажимаем "."
""" ПОДВИНУТЬ НАПРАВО: выделяем строки на нажимаем SHIFT+> и ещё несколько раз "."
"# tabstop      -> Indentation width in spaces
"# shiftwidth   -> Autoindentation width in spaces
"# expandtab    -> Use actual spaces instead of tabs
"# retab        -> Convert existing tabs to spaces
set tabstop=4
set expandtab
set autoindent
set smartindent
set shiftwidth=4
set cindent
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" for move text by shift+v ">" OR shift+v "<"
" set smartindent
set tabstop=4
set expandtab
set shiftwidth=4
""""
""""


""" перемещать строки вверх вниз alt+up\down:
nnoremap <A-Up> :m-2<CR>
inoremap <A-Up> <Esc>:m-2<CR>
nnoremap <A-Down> :m+<CR>
inoremap <A-Down> <Esc>:m+<CR>
""""


"""
" поиск по слову под курсором назад
nnoremap <c-e> *
" поиск по слову под курсором вперёд
nnoremap <c-q> #
""""


""" плавная построчная прокрутка на ctrl e && ctrl w: ВВЕРХ
nnoremap <S-q> <c-y>
inoremap <S-q> <c-y>
""""


""" плавная построчная прокрутка на ctrl e && ctrl w: ВНИЗ
nnoremap <S-e> <c-e>
inoremap <S-e> <c-e>
""""


""" отключение в режиме редактирования pgup\pgdown по shift+up shift+down
nnoremap  <S-Up>    <c-y>
nnoremap  <S-DOwn>  <c-e>
inoremap  <S-Up>    <c-y>
inoremap  <S-DOwn>  <c-e>
snoremap  <S-Up>    <c-y>
snoremap  <S-DOwn>  <c-e>
vnoremap  <S-Up>    <c-y>
vnoremap  <S-DOwn>  <c-e>
noremap   <S-Up>    <c-y>
noremap   <c-DOwn>  <c-e>
""""


""" плавная прокрутка построчная shift + up\down во всех режимах!
nnoremap  <c-Up>    <c-y>
nnoremap  <c-DOwn>  <c-e>
inoremap  <c-Up>    <c-y>
inoremap  <c-DOwn>  <c-e>
snoremap  <c-Up>    <c-y>
snoremap  <c-DOwn>  <c-e>
vnoremap  <c-Up>    <c-y>
vnoremap  <c-DOwn>  <c-e>
noremap   <c-Up>    <c-y>
noremap   <c-DOwn>  <c-e>
""""


""" сохранить на ctrl s
nnoremap <c-s> <esc>:w<enter>
inoremap <c-s> <esc>:w<enter>
""""


""" рестарт nginx
nnoremap <c-n> <esc>:w<enter>:!nginx -t && nginx -s reload<enter>
inoremap <c-n> <esc>:w<enter>:!nginx -t && nginx -s reload<enter>
""""


""" fix cyrillic symbols
set encoding=utf-8
""""


""" следующий блок будет при открытии документа переносить на старую позицию
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
""""


""" Fix broken insert while using Tmux.
if &term =~ "screen"
    " Фиг его знает как лучше. нужно тестить. я не помню на каком сервере были ошибки
    " Следующие две строчки можно раскоммнтировать или закомментировать. 
    "let &t_BE = "\e[?2004h"
    "let &t_BD = "\e[?2004l"
    exec "set t_PS=\e[200~"
    exec "set t_PE=\e[201~"
endif
""""


""" Включение подсветки для кастомных файлов
""" все варанты пожно глянуть тут /usr/share/vim/vim74/syntax/
" highlight set syntax for php-fpm
"autocmd BufRead,BufNewFile *.conf set syntax=dosini
autocmd BufRead,BufNewFile /etc/php/*/fpm/*.conf set syntax=dosini
autocmd BufRead,BufNewFile /etc/php/*/fpm/pool.d/*.conf set syntax=dosini
autocmd BufRead,BufNewFile /etc/php-fpm.d/*.conf set syntax=dosini
autocmd BufRead,BufNewFile /etc/php-fpm.conf set syntax=dosini
autocmd BufRead,BufNewFile /etc/nginx/conf.d/kpb.lt.ShortCutter.conf set syntax=dosini
autocmd BufRead,BufNewFile kpb.lt.ShortCutter.conf set syntax=zsh
autocmd BufRead,BufNewFile /etc/nginx/conf.d/*.conf set syntax=zsh
autocmd BufRead,BufNewFile /opt/scripts/domains.txt set syntax=zsh
autocmd BufRead,BufNewFile *.ini setl filetype=ini_files_type syntax=dosini
autocmd BufRead,BufNewFile /bin/b.cmd set syntax=zsh
autocmd BufRead,BufNewFile /bin/b.rsynct set syntax=zsh
autocmd BufRead,BufNewFile /root/.bashrc.kas.s set syntax=zsh
"autocmd BufRead,BufNewFile *.log set syntax=zsh
autocmd BufRead,BufNewFile *.log setl filetype=log_files_type syntax=slate
autocmd BufRead,BufNewFile *.yml setl filetype=yml_files_type syntax=slate
autocmd BufRead,BufNewFile *.yaml setl filetype=yml_files_type syntax=slate
""""


""" Закомментировать\раскомментировать строчку, либо выдленный блок текста по "cc" и по ctrl+m
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType arduino,php      let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType zsh              let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType yaml             let b:comment_leader = '# '
autocmd FileType matlab,tex       let b:comment_leader = '% '
autocmd FileType vim              let b:comment_leader = '" '
autocmd FileType ini_files_type   let b:comment_leader = '; '
autocmd FileType log_files_type   let b:comment_leader = '# '
autocmd FileType yml_files_type   let b:comment_leader = '# '
""""

""
""" Старый вариант комментирования\раскомментирования:
" в этом вариане всегда комментирование происходит УЧИТЫВАЯ отступы.
""
" function! CommentToggle()
"     execute ':silent! s/\([^ ]\)/' . escape(b:comment_leader,'\/') . ' \1/'
"     execute ':silent! s/^\( *\)' . escape(b:comment_leader,'\/') . ' \?' . escape(b:comment_leader,'\/') . ' \?/\1/'
" endfunction
" noremap   <silent> cc         :call CommentToggle()<CR>
" noremap   <silent> <c-m>      :call CommentToggle()<CR>
""""

""
""" Новый вариант комментирования\раскомментирования:
" внизу написаны два варианта комментирования:
" 1: в этом случае закомменчено будет начиная с начала строки, не смотря на отступ. строка 453
" 2: в этом случае закомменчено будет рядом включая отступ. строка 455
""
function! ToggleComment() range
    "Ensure we know the comment leader.
    if !exists('b:comment_leader')
        echo "Unknown comment leader."
        return
    endif
    "Save the initial cursor position, to restore later.
    let l:inipos = getpos('.')
    "Make a list of all of the line numbers in the range which are already commented.
    let l:commented_lines = []
    for i in range(a:firstline, a:lastline)
        if getline(i) =~ '^\s*' . b:comment_leader
            let l:commented_lines = add(l:commented_lines, i)
        endif
    endfor
    " If every line in the range is commented, set the action to uncomment.
    " Otherwise, set it to comment.
    let l:i1 = index(l:commented_lines, a:firstline)
    let l:i2 = index(l:commented_lines, a:lastline)
    if l:i1 >= 0 && l:i2 >= 0 && (l:i2 - l:i1) == (a:lastline - a:firstline)
        let l:action = "uncomment"
    else
        let l:action = "comment"
    endif
    " Loop through the range, commenting or uncommenting based on l:action.
    for i in range(a:firstline, a:lastline)
        " Move to line i.
        exec "exe " . i
        " Perform the action.
        if l:action == "comment"
            " в этом случае закомменчено будет начиная с начала строки, не смотря на отступ.
            exec 'normal! 0i' . b:comment_leader
            " в этом случае закомменчено будет рядом включая отступ
            " exec 'normal! 1i' . b:comment_leader
        else
            execute 'silent s,' . b:comment_leader . ',,'
        endif
    endfor
    " Restore the initial position.
    call setpos('.', l:inipos)
endfunction

"noremap   <Leader>k           :call ToggleComment()<CR>
noremap   <silent> cc         :call ToggleComment()<CR>
noremap   <silent> <c-m>      :call ToggleComment()<CR>
""""



""" Исправляет вставку лесенкой fix ladder paste:
set paste
set noai
set noautoindent
""""



""" Выделение текста по shift+up shift+down прямо без перехода в режим визуализации
""" shift+arrow selection
nmap <S-Up> V<Up>
nmap <S-Down> V<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
""""


""" Копирование текста по CTRL+ALT+up CTRL+ALT+down
nnoremap <A-S-UP> Yp
inoremap <A-S-UP> <Esc> Ypi
nnoremap <A-S-Down> Yp
inoremap <A-S-Down> <Esc> Ypi
inoremap <A-S-Down> <Esc> Ypi
""""


""" Исправляет move block вместо табов в пробелы.
set shiftwidth=4
set expandtab
set tabstop=4
retab!
""""


""" двигать блоки текста по tab ctrl+tab
nnoremap <Tab> >_
nnoremap <C-Tab> <<_
inoremap <C-Tab> <CD>
vnoremap <Tab> >gv
vnoremap <C-Tab> <gv
""""

""" запуск текущей строчки, на которой находится курсор в интерпретаторе bash
function! ExecuteCurrentLineInBash()
    let current_line = getline('.')
    execute ":w !source ~/.bashrc 2>/dev/null && /usr/bin/run_from_vim " . shellescape(current_line) . " 2>&1 | grep -v stty"
endfunction

function! ExecuteSelectedLinesInBash()
    let selected_lines = getline("'<", "'>")
    execute ":w !source ~/.bashrc 2>/dev/null && /usr/bin/run_from_vim " . shellescape(join(selected_lines, "\n")) . " 2>&1 | grep -v stty"
endfunction

nnoremap <C-f> :call ExecuteCurrentLineInBash()<CR>
vnoremap <C-f> :call ExecuteSelectedLinesInBash()<CR>
""""

