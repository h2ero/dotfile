let g:loadFF = 1
function! ExpandCamelCase()
    let word = expand("<cWORD>")
    let word = substitute(word, '\([A-Z]\)', ' \l\1', 'g')
    let word = substitute(word, '\([a-z]\)', '\U\1', '')
    let word = escape(word,']\/*')
    let g:nowPos = getpos(".")
    exec 's/\S*\%#\S*/'.word
    call setpos(".", g:nowPos)
endfunction
map ge :call ExpandCamelCase()<CR>

function! TransCamelCase()
    let word = expand("<cWORD>")
    let word = substitute(word, '_\([A-Za-z]\)', '\U\1', 'g')
    let word = escape(word,']\/*')
    let g:nowPos = getpos(".")
    exec 's/\S*\%#\S*/'.word
    call setpos(".", g:nowPos)
endfunction
map g<Space> :call TransCamelCase()<CR>
