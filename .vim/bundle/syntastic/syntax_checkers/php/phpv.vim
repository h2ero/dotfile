"============================================================================
"File:        phpv.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Martin Grenfell <martin.grenfell at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================
"
" See here for details of phpv
"    - phpv (see http://pear.php.net/package/PHP_CodeSniffer)
"
if exists("g:loaded_syntastic_php_phpv_checker")
    finish
endif
let g:loaded_syntastic_php_phpv_checker=1

function! SyntaxCheckers_php_phpv_IsAvailable()
    return executable('phpcs')
endfunction

function! SyntaxCheckers_php_phpv_GetLocList()
    let makeprg = syntastic#makeprg#build({
        \ 'exe': 'phpcs',
        \ 'args': '--report=csv --standard=VariableAnalysis',
        \ 'filetype': 'php',
        \ 'subchecker': 'phpcs' })

    let errorformat =
        \ '%-GFile\,Line\,Column\,Type\,Message\,Source\,Severity,'.
        \ '"%f"\,%l\,%c\,%t%*[a-zA-Z]\,"%m"\,%*[a-zA-Z0-9_.-]\,%*[0-9]'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'subtype': 'Style' })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'php',
    \ 'name': 'phpv'})
