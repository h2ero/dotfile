" Language: Python (python)
" Author: pydave
" License: The MIT License

function! ctrlp#funky#python#filters()
  let filters = [
        \ { 'pattern': '\v\C^\s*class\s+\w+\s*(\([^\)]+\))?:',
        \   'formatter': ['\v\C^\s*', '', ''] },
        \ { 'pattern': '\v\C^\s*def\s+\w+\s*(\_.*):',
        \   'formatter': ['\v\C^\s*', '', ''] }
  \ ]
  return filters
endfunction
