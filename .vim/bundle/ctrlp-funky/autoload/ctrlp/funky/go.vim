" Language: GO (go)
" Author: h2ero
" License: The MIT License

let s:filter = [{ 'pattern': '\v\s*func\s+\w.+\s*\(',
                \ 'filter': []}
                \ ]

function! ctrlp#funky#go#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#go#get_filter()
  return s:filter
endfunction

