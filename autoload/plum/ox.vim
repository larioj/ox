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
  if vsel[0] =~ '-- ox export '
    let ctx.match = vsel
    return v:true
  endif
  return v:false
endfunction

function! plum#ox#ApplyCheckedExport(ctx)
  let ctx = a:ctx
  let executable = 'ox'
  let vsel = ctx.match
  let [start, end] = plum#ox#GetImportList()
  let imports = getline(start, end)
  let redir = ""
  if ctx.shift
    let redir = '2> /dev/null'
  endif
  let cmd =
        \ executable . " <<'EOF' " . redir  . " \n" .
        \ join(imports, "\n") . "\n\n" .
        \ join(vsel, "\n") .
        \ "\nEOF"
  if ctx.shift
    silent let import = system("/bin/bash -c " . shellescape(cmd))
    let import = trim(import)
    '<,'>d
    call append(end, import)
  else
    let ctx.match = cmd
    return plum#term#SmartTerminal().apply(ctx)
  endif
endfunction

function! plum#ox#GetImportList()
  let start = -1
  let end = -1
  let i = 1
  while i <= line('$')
    let ln = getline(i)
    if start < 0 && ln =~# '^import '
      let start = i
      let end = i
    elseif start > -1 && (ln ==# '' || ln[0] ==# ' ' || ln =~# '^import ' || ln =~# '^--')
      let end = i
    elseif start > -1
      break
    endif 
    let i = i + 1
  endwhile

  if end > 3 && getline(end) =~# "-- ox export"
    let end = end - 1
  endif

  if end > 2 && trim(getline(end)) =~# ""
    let end = end - 1
  endif

  if start > 1 && getline(start - 1) =~# "-- ox impurity"
    let start = start - 1
  endif

  return [start, end]
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
