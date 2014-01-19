let g:loadFF = 1
function! ExpandCamelCase()
    let word = expand("<cWORD>")
    let word = substitute(word, '\([A-Z]\)', ' \l\1', 'g')
    let word = escape(word,']\/*')
    let g:nowPos = getpos(".")
    exec 's/\S*\%#\S*/'.word
    call setpos(".", g:nowPos)
endfunction
