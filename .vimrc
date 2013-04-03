colorscheme molokai
set ff=unix
set t_Co=256
set guifont=Monaco:h10       " 字体 && 字号
set tabstop=4                " 设置tab键的宽度
set shiftwidth=4             " 换行时行间交错使用4个空格
set softtabstop=4            " Sets the number of columns for a TAB
set smarttab                 " make tab insert indents instead of tabs at the beginning of a line
set expandtab
set autoindent               " 自动对齐
set backspace=2              " 设置退格键可用
set smartindent              " 智能自动缩进
set cindent shiftwidth=4     " 自动缩进4空格
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
syntax enable                " 打开语法高亮 syntax on                    " 开启文件类型侦测
"filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
"filetype plugin indent on    " 启用自动补全

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
set foldmethod=indent        " 选择代码折叠类型
set foldlevel=100            " 禁止自动折叠

set laststatus=2             " 开启状态栏信息
"set cmdheight=2              " 命令行的高度，默认为1，这里设为2

" 每行超过80个的字符用下划线标示
au BufRead,BufNewFile *.asm,*.c,*.cpp,*.java,*.cs,*.sh,*.lua,*.pl,*.pm,*.py,*.rb,*.erb,*.hs,*.vim match Underlined /.\%81v/
"php mannul"
au FileType php set keywordprg=:help



" 设置编码
set fenc=utf-8
set encoding=utf-8
set fileencodings=utf-8,gbk,cp936,latin-1
" 解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" 解决consle输出乱码
language messages en_US.utf-8

""
""" ======= 引号 && 括号自动匹配 ======= "
""
"":inoremap ( ()<ESC>i
""
"":inoremap ) <c-r>=ClosePair(')')<CR>
""
"":inoremap { {}<ESC>i
""
"":inoremap } <c-r>=ClosePair('}')<CR>
""
"":inoremap [ []<ESC>i
""
"":inoremap ] <c-r>=ClosePair(']')<CR>
""
""":inoremap < <><ESC>i
""
""":inoremap > <c-r>=ClosePair('>')<CR>
""
"":inoremap " ""<ESC>i
""
"":inoremap ' ''<ESC>i
""
"":inoremap ` ``<ESC>i
""
""function ClosePair(char)
""	if getline('.')[col('.') - 1] == a:char
""		return "\<Right>"
""	else
""		return a:char
""	endif
""endf

" TxtBrowser          高亮TXT文本文件
au BufRead,BufNewFile *.txt setlocal ft=txt

" :FencView           查看文件编码和更改文件编码
let g:fencview_autodetect=1


"载入模板
let g:v_author='h2ero'
let g:v_email='122750707@qq.com'
let g:v_home='http://blog.h2ero.cn'


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
		elseif &filetype == "php"
			exec "!php %"
		elseif &filetype == "python"
			exec "!python %<.py"
		elseif &filetype == "perl"
			exec "!perl %<.pl"
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
		elseif &filetype == "python"
			exec "!python %<.py"
		elseif &filetype == "perl"
			exec "!perl %<.pl"
		elseif &filetype == "ruby"
			exec "!ruby %<.rb"
        endif
endfunc

" Ctrl + C 一键保存、编译
map <c-c> :call CompileCode()<CR>
imap <c-c> <ESC>:call CompileCode()<CR>
vmap <c-c> <ESC>:call CompileCode()<CR>

"分屏显示切换
noremap gn <c-w><c-w>
noremap gN <c-w>h
"分屏打开关闭
noremap ,t :TlistToggle<CR>
noremap ,f :NERDTreeToggle<CR>
noremap ,c :close<CR>


"pathogen"
call pathogen#runtime_append_all_bundles()

"taglist
"nnoremap <silent> <F8> :TlistToggle<CR>
"ctags -R . Ctrl+]跳转到定义处 Ctrl+o 跳转回 <space> 查看原型定义 o 新窗口打开当前tag u 更新tag
"let Tlist_Auto_Open=1 "自动打开
let Tlist_Use_Right_Window=1 "左边显示
let Tlist_File_Fold_Auto_Close=1 "打开其他文件的时候自动关闭,只显示一个文件的tag
let Tlist_Auto_Update=1 "自动更新，包含新文件时候
let Tlist_Exit_OnlyWindow=1"Close Vim if the taglist is the only window.
set title titlestring=%<%f\ %([%{Tlist_Get_Tagname_By_Line()}]%) "状态栏标题
set statusline=%<%f%=%([%{Tlist_Get_Tagname_By_Line()}]%) "窗口标题
let Tlist_Compact_Format=1 "不显示空白行
set tags=tags;/ "找不到tags文件到上层找寻"
"let Tlist_Ctags_Cmd = '`brew --prefix`/bin/ctags'
noremap gl :tnext<CR>

"NERDTree
"nnoremap <silent> <F7> :NERDTree<CR>
let NERDTreeIgnore=['\.pyc$']

"pydiction
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'

"zen coding
"syntastic
" 在打开文件的时候检查
"let g:syntastic_check_on_open=1
"phpcs，tab4个空格，编码参考使用CodeIgniter风格
let g:user_zen_expandabbr_key = '<c-e>'
"let g:use_zen_complete_tag = 1
"let g:syntastic_phpcs_conf = '--tab-width=4 --standard=CodeIgniter'

"Powerline
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors
let g:Powerline_symbols ='fancy' 
let g:Powerline_dividers_override = ['>>', '>', '<<', '<']
"let g:Powerline_theme = 'skwp'
"let g:Powerline_mode_n ='NORMAL'
let g:Powerline_stl_path_style = 'full'

"php 自动补全
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType python set omnifunc=pythoncomplete#CompletePHP
"注释
"map <c-c> :call PhpDoc()<CR>

"set cursorcolumn
"set cursorline

" Rope AutoComplete
let ropevim_vim_completion = 1
let ropevim_extended_complete = 1
let g:ropevim_autoimport_modules = ["os.*","traceback","django.*", "xml.etree"]
"imap  <buffer><Tab> <M-/>
"imap  <buffer><Tab> <C-R>=RopeCodeAssistInsertMode()<CR>
"color
""highlight PmenuSel ctermbg=DarkI""
""FuzzyFinder
"map <C-S-R> :FufFileRecursive<CR>
"map ,s :FufFile **/<CR>

"Now all operations such as yy, D, and P work with the clipboard. No need to 'prefix them with \"* or \"+.
set clipboard=unnamed

""ctrlp
let g:ctrlp_map = ',p'
nmap ,b :CtrlPBuffer<CR>
nmap ,m :CtrlPMRU<CR>
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip 
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_show_hidden = 0

""less css  syntax
au BufNewFile,BufRead *.less set cinkeys=0{,0},0),0#,!^F,o,O,e " 默认为"0{,0},0),:,0#,!^F,o,O,e" 去掉: ,避免css中出现:的时候缩进改变
au BufNewFile,BufRead *.less runtime! indent/css.vim
au BufNewFile,BufRead *.less set filetype=css
au BufNewFile,BufRead *.less  source $HOME/.vim/syntax/less.vim
"" <leader>  1000ms
let g:EasyMotion_leader_key = '<Leader>'

" quick edit vimrc  and execute it
:nnoremap <leader>ev :vsplit $MYVIMRC<CR>
:nnoremap <leader>sv :source $MYVIMRC<CR>
" demo
:nnoremap ,d :source ~/.demorc<CR>

"
:iabbrev @@    122750707@qq.com

au BufRead,BufNewFile .pentadactylrc set filetype=pentadactyl
au! Syntax pentadactyl source ~/.vim/syntax/pentadactyl.vim

"script
":source ~/.vim/script/phpformat.vim

"vimwiki
let g:vimwiki_table_mappings = 0 " 避免与snipmate的tab冲突
let g:vimwiki_camel_case = 0
let g:vimwiki_list = [{'path': '~/.vimwiki/vim/',
                      \'path_html': '~/.vimwiki/',
                      \'html_header': '~/.vim/templates/vimwiki/header.tpl',
                      \'auto_export': 1,}]
:nnoremap ,wd :VimwikiToggleListItem<CR>

set shell=zsh
"set shellcmdflag=-d

"snipmate
let g:snips_author = 'h2ero <122750707@qq.com>'

"phpunit
:nnoremap ,pu :!clear&&phpunit UnitTest % <CR>

"test nginx config file
:nnoremap ,nt :!nginx -t -c % <CR>
"pbcopy
vmap ,xc y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap ,xp :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

"map CR
inoremap <S-CR> <CR>
let g:acp_enableAtStartup = 1

"////////////////////////////////////////////////////////////////////////////////
"//
"//  neocomplcache  config
"//
"////////////////////////////////////////////////////////////////////////////////

" Disable AutoComplPop. Comment out this line if AutoComplPop is not installed.
let g:acp_enableAtStartup = 0
" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 3
" buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder 
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define file-type dependent dictionaries.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword, for minor languages
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion. Not required if they are already set elsewhere in .vimrc
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion, which require computational power and may stall the vim. 
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
"neocomplcache end

"hi Normal ctermbg=NONE      
