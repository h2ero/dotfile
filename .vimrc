set guifont=Monaco:h10       " 字体 && 字号
set expandtab
set tabstop=4                " 设置tab键的宽度
set shiftwidth=4             " 换行时行间交错使用4个空格
set autoindent               " 自动对齐
set backspace=2              " 设置退格键可用
set cindent shiftwidth=4     " 自动缩进4空格
set smartindent              " 智能自动缩进
set ai!                      " 设置自动缩进
set nu!                      " 显示行号
"set showmatch               " 显示括号配对情况
set mouse=a                  " 启用鼠标
set ruler                    " 右下角显示光标位置的状态行
"set incsearch                " 查找book时，当输入/b时会自动找到
"set hlsearch                 " 开启高亮显示结果
set incsearch                " 开启实时搜索功能
set nowrapscan               " 搜索到文件两端时不重新搜索
set nocompatible             " 关闭兼容模式
set vb t_vb=                 " 关闭提示音
"set cursorline              " 突出显示当前行
set hidden                   " 允许在有未保存的修改时切换缓冲区
"set list                     " 显示Tab符，使用一高亮竖线代替
"set listchars=nbsp:%,trail:-,
syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全

if has("gui_running")
    au GUIEnter * simalt ~x  " 窗口启动时自动最大化
    "winpos 20 20            " 指定窗口出现的位置，坐标原点在屏幕左上角
    "set lines=20 columns=90 " 指定窗口大小，lines为高度，columns为宽度
    "set guioptions-=m       " 隐藏菜单栏
    set guioptions-=T        " 隐藏工具栏
    "set guioptions-=L       " 隐藏左侧滚动条
    "set guioptions-=r       " 隐藏右侧滚动条
    "set guioptions-=b       " 隐藏底部滚动条
    "set showtabline=0       " 隐藏Tab栏
endif

set writebackup              " 设置无备份文件
set nobackup
set autochdir                " 设定文件浏览器目录为当前目录
"set nowrap                  " 设置不自动换行
set foldmethod=syntax        " 选择代码折叠类型
set foldlevel=100            " 禁止自动折叠

set laststatus=2             " 开启状态栏信息
"set cmdheight=2              " 命令行的高度，默认为1，这里设为2

" 每行超过80个的字符用下划线标示
au BufRead,BufNewFile *.asm,*.c,*.cpp,*.java,*.cs,*.sh,*.lua,*.pl,*.pm,*.py,*.rb,*.erb,*.hs,*.vim 2match Underlined /.\%81v/


" 设置编码
set fenc=utf-8
set encoding=utf-8
set fileencodings=utf-8,gbk,cp936,latin-1
" 解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" 解决consle输出乱码
language messages en_US.utf-8


" For Haskell
:let hs_highlight_delimiters=1            " 高亮定界符
:let hs_highlight_boolean=1               " 把True和False识别为关键字
:let hs_highlight_types=1                 " 把基本类型的名字识别为关键字
:let hs_highlight_more_types=1            " 把更多常用类型识别为关键字
:let hs_highlight_debug=1                 " 高亮调试函数的名字
:let hs_allow_hash_operator=1             " 阻止把#高亮为错误


" ======= 引号 && 括号自动匹配 ======= "

:inoremap ( ()<ESC>i

:inoremap ) <c-r>=ClosePair(')')<CR>

:inoremap { {}<ESC>i

:inoremap } <c-r>=ClosePair('}')<CR>

:inoremap [ []<ESC>i

:inoremap ] <c-r>=ClosePair(']')<CR>

":inoremap < <><ESC>i

":inoremap > <c-r>=ClosePair('>')<CR>

:inoremap " ""<ESC>i

:inoremap ' ''<ESC>i

:inoremap ` ``<ESC>i

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf


" MiniBufExplorer     多个文件切换 可使用鼠标双击相应文件名进行切换
let g:miniBufExplMapWindowNavVim=1
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplModSelTarget=1

" :Tlist              调用TagList
let Tlist_Show_One_File=1                    " 只显示当前文件的tags
let Tlist_Exit_OnlyWindow=1                  " 如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_Use_Right_Window=1                 " 在右侧窗口中显示
let Tlist_File_Fold_Auto_Close=1             " 自动折叠

" TxtBrowser          高亮TXT文本文件
au BufRead,BufNewFile *.txt setlocal ft=txt

" :FencView           查看文件编码和更改文件编码
let g:fencview_autodetect=1

" :LoadTemplate       根据文件后缀自动加载模板
let g:template_path='D:\Apps\Gvim\vimfiles\template\'

" :AuthorInfoDetect   自动添加作者、时间等信息，本质是NERD_commenter && authorinfo的结合
let g:vimrc_author='Ruchee'
let g:vimrc_email='my@ruchee.com'
let g:vimrc_homepage='http://www.ruchee.com'

" Ctrl + H            将光标移到行首
imap <c-h> <ESC>I

" Ctrl + J            将光标移到下一行的行首
imap <c-j> <ESC>jI

" Ctrl + K            将光标移到上一行的末尾
imap <c-k> <ESC>kA

" Ctrl + L            将光标移到行尾
imap <c-l> <ESC>A

" Ctrl + Z            取代ESC模式键
imap <c-z> <ESC>

" Ctrl + S            保存文件
map <c-s> <ESC>:w<CR>
imap <c-s> <ESC>:w<CR>a
vmap <c-s> <ESC>:w<CR>

" Ctrl + E            一步加载语法模板和作者、时间信息 [非插入模式]
map <c-e> <ESC>:LoadTemplate<CR><ESC>:AuthorInfoDetect<CR><ESC>Gi
vmap <c-e> <ESC>:LoadTemplate<CR><ESC>:AuthorInfoDetect<CR><ESC>Gi

" Ctrl + E            在当前行添加C/C++/Java语言的多行注释 [插入模式]
imap <c-e> /*  */<ESC>hhi

" nt                  打开NERDTree [非插入模式]
map nt :NERDTree<CR>

" tl                  打开Taglist [非插入模式]
map tl :Tlist<CR><c-l>


" ======= 编译 && 运行 ======= "

" 编译C源文件
func! CompileGcc()
    exec "w"
    let compilecmd="!gcc -Wall -pedantic -std=c99 "
    let compileflag="-o %<"
    exec compilecmd." % ".compileflag
endfunc

" 编译C++源文件
func! CompileCpp()
    exec "w"
    let compilecmd="!g++ -Wall -pedantic -std=c++98 "
    let compileflag="-o %<"
    exec compilecmd." % ".compileflag
endfunc

" 编译Java源文件
func! CompileJava()
	exec "w"
    exec "!javac %"
endfunc

" 编译Haskell源文件
func! CompileHaskell()
	exec "w"
	let compilecmd="!ghc --make "
	let compileflag="-o %<"
	exec compilecmd." % ".compileflag
endfunc

" 根据文件类型自动选择相应的编译函数
func! CompileCode()
        exec "w"
        if &filetype == "c"
			exec "call CompileGcc()"
        elseif &filetype == "cpp"
			exec "call CompileCpp()"
		elseif &filetype == "java"
			exec "call CompileJava()"
		elseif &filetype == "haskell"
			exec "call CompileHaskell()"
		elseif &filetype == "lua"
			exec "!lua %<.lua"
		elseif &filetype == "perl"
			exec "!perl %<.pl"
        elseif &filetype == "python"
			exec "!python %<.py"
		elseif &filetype == "ruby"
			exec "!ruby %<.rb"
        endif
endfunc

" 运行可执行文件
func! RunResult()
        exec "w"
        if &filetype == "c"
			exec "! %<"
        elseif &filetype == "cpp"
			exec "! %<"
		elseif &filetype == "java"
			exec "!java %<"
		elseif &filetype == "haskell"
			exec "! %<"
		elseif &filetype == "lua"
			exec "!lua %<.lua"
		elseif &filetype == "perl"
			exec "!perl %<.pl"
        elseif &filetype == "python"
			exec "!python %<.py"
		elseif &filetype == "ruby"
			exec "!ruby %<.rb"
        endif
endfunc

" Ctrl + C 一键保存、编译
map <c-c> :call CompileCode()<CR>
imap <c-c> <ESC>:call CompileCode()<CR>
vmap <c-c> <ESC>:call CompileCode()<CR>

" Ctrl + R 一键保存、运行
map <c-r> :call RunResult()<CR>
map <c-R> :redo<CR>
imap <c-r> <ESC>:call RunResult()<CR>
vmap <c-r> <ESC>:call RunResult()<CR>

"map
noremap gn <c-w><c-w>
noremap gN <c-w>h
"pathogen"
call pathogen#runtime_append_all_bundles()
""taglist
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Auto_Open=1 "自动打开
let Tlist_Use_Right_Window=1 "左边显示
let Tlist_File_Fold_Auto_Close=1 "打开其他文件的时候自动关闭,只显示一个文件的tag
let Tlist_Auto_Update=1 "自动更新，包含新文件时候
set title titlestring=%<%f\ %([%{Tlist_Get_Tagname_By_Line()}]%) "状态栏标题
set statusline=%<%f%=%([%{Tlist_Get_Tagname_By_Line()}]%) "窗口标题
let Tlist_Compact_Format=1 "不显示空白行
"NERDTree
nnoremap <silent> <F7> :NERDTree<CR>
let NERDTreeIgnore=['\.pyc$']
"pydiction
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
"zen coding
"syntastic
" 在打开文件的时候检查
let g:syntastic_check_on_open=1
"phpcs，tab4个空格，编码参考使用CodeIgniter风格
let g:syntastic_phpcs_conf = "--tab-width=4 --standard=CodeIgniter"
"Powerline
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors
let g:Powerline_symbols ='fancy' 
let g:Powerline_dividers_override = ['>>', '>', '<<', '<']
"let g:Powerline_theme = 'skwp'
"let g:Powerline_mode_n ='NORMAL'
let g:Powerline_stl_path_style = 'full'
"php 自动补全
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"注释
map <c-c> :call PhpDoc()<CR>

"set cursorcolumn
"set cursorline

