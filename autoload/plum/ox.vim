function! plum#ox#CheckedExport()
  return plum#CreateAction(
        \ 'plum#ox#CheckedExport',
        \ function('plum#ox#IsExport'),
        \ function('plum#ox#ApplyCheckedExport'),
        \ )
endfunction

function! plum#ox#IsExport(ctx)
  let ctx = a:ctx
  if ctx.mode !=# 'v' || &filetype !=# 'haskell'
    return v:false
  endif
  let vsel = s:GetVisualSelection()
  if len(vsel) < 1
    return v:false
  endif
  if vsel[0] =~ '-- ox export'
    return v:true
  endif
  return v:false
endfunction

function! plum#ox#ApplyCheckedExport(ctx)
endfunction

function! plum#ox#GetImportList()
  let start = -1
  let end = -1
  let i = 1
  while i <= line('$')
    let ln = getline(i)
    if start < 0 && ln =~# '^import'
      let start = i
      let end = i
    elseif ln ==# '' || ln[0] ==# ' ' || ln =~# '^import'
      let end = i
    else
      break
    endif 
    let i = i + 1
  endwhile
  return getline(start, end)
endfunction

function! s:GetVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return []
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return lines
endfunction
