"format code
"http://kohanaframework.org/3.3/guide/kohana/conventions

func! Add_space()

    let now_line = line('.')
    "exec "inoremap <CR> <CR>"
    exec "normal! a\<CR>\<Esc>"
    let n_line = getline(now_line)

    " str replace
    let strlist = []
    let flag = 0
    let index= 0
    while flag == 0
        let replacelist = matchlist(n_line, '\([''"]\)\{1}\(.\{-}\)\\\@<!\1\{1}')
        if len(replacelist) == 0 
            let flag = 1
        else
            let rstr = replacelist[1].replacelist[2].replacelist[1]
            call add(strlist,['STR'.index,rstr])
            let n_line = substitute(n_line,rstr,'STR'.index,'')
            let index+=1
        endif
    endwhile

    " 1.  =+*<-%/ exclude => != !== .= += <= 
    let n_line = substitute(n_line,'\s*\(!\|!=\|+=\|<=\|\.\)\@<!\([%/=*+<-]\+[>]\@!\)\s*',' \2 ','g')

    " 2.  ,                eg : array('a' => 'b', 'c' => 'd')
    let n_line = substitute(n_line,'\s*\([,]\+\)\s*','\1 ','g')

    " 3.  ()               eg : if ( $foo )  exclude define('') 
    let n_line = substitute(n_line,'\(if\|while\|for\|foreach\|switch\)\@<=\s*\([(]\+\)\(.\{-}\)\([)]\+\)\s*',' \2\3\4 ','g')

    " 4.  =>               eg : array('a' => 'b', 'c' => 'd')
    let n_line = substitute(n_line,'\s*\(=>\)\s*',' \1 ','g')

    " 5.  + - * /  exclude ++ --
    "let n_line = substitute(n_line,'\s*\([-]\{2,}\)\s*','\1','g')

    " 6.  != !== += .=     eg : if ($foo !== FALSE)  $a += 5;
    let n_line = substitute(n_line,'\s*\(!=\+\|+=\|\.=\|<=\)\s*',' \1 ','g')

    " 7.  (!               eg : if ( ! $foo)
    let n_line = substitute(n_line,'\s*[(]\@<=\(!\)\s*',' \1 ','g')

    " 8.  || &&            eg : if (($foo && $bar) || ($b && $c))
    let n_line = substitute(n_line,'\s*\(&&\|||\)\s*',' \1 ','g')

    " 9.  (int)            eg : if ( (int) $foo) in up regex will replace it like if((int) $foo), follow will fix it.
    let n_line = substitute(n_line,'\s*(\(int\|bool\|float\|string\|binary\|array\|object\|unset\))\s*',' (\1) ','g')

    " 10.  ?:              eg : $foo = $bar ? $foo : $bar;
    let n_line = substitute(n_line,'\s*\(?\)\s*\(.\{-}\)\s*:\@<!\(:\):\@!\s*',' \1 \2 \3 ','g')

    " 11. for(;;)          eg : for($i = 0; $i < 100; $i++) 
    let n_line = substitute(n_line,'\(for\s(\)\@<=\([^;]*\)\(;\)\([^;]*\)\(;\)','\2\3 \4\5 ','g')

    " 12. && ||  replace with and or
    let n_line = substitute(n_line,'\s*||\s*',' OR ','g')
    let n_line = substitute(n_line,'\s*&&\s*',' AND ','g')

    " 13. and or xor not      eg : if (1 AND 2 OR 3 XOR 4)  exclude error word contains or
    let n_line = substitute(n_line,'\s*\w\@<!\(\cand\|\cor\|\cxor\|\cnot\)\w\@!\s*',' \U\1 ','g')

    "let n_line = substitute(n_line,'\s*\(for(\)\@<=.*\s*\(;\).*\s*','\2 ','g')

    "let n_line=substitute(n_line,'\s*\([=+]\+\)\s*',' \1 ','g')

    " str restore
    let index = len(strlist) - 1
    while len(strlist) > 0
        let n_line = substitute(n_line,strlist[index][0],strlist[index][1],'')
        unlet strlist[index]
        let index-=1
    endwhile

    call setline(now_line,n_line)
    "exec now_line."s/\\\s*\\\([=+]\\\+\\\)\\\s*/ \\1 /ge"
    "exec "inoremap <CR> <Esc>:call Add_space()<CR>"

endfunc

func! PHP_space()
    let now_line = line( '.' )
    let n_line = getline(now_line)
    let html = matchstr(n_line, '^\s*[<.#]')
    if empty(html) 
        call Add_space()
    else
        exec "normal! \<ESC>a\<CR>"
        echo "this is html"
        "throw "no url recognized into ``".n_line."''"
    endif
endfunc

":inoremap <CR> <Esc>:call Add_space()<CR>
"inoremap <CR> <Esc>:call Add_space()<CR>
au FileType php inoremap <CR> <Esc>:call PHP_space()<CR>
