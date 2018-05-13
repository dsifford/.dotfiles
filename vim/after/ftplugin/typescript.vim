
function! TsIncludeExpr(file)
  if (filereadable(a:file))
    return a:file
  else
    let l:file2=substitute(a:file,'$','/index.ts','g')
    return l:file2
  endif
endfunction

setl include=import\_s.\\zs[^'\"]*\\ze
setl includeexpr=TsIncludeExpr(v:fname)
setl suffixesadd=.ts,.tsx

let &l:path .= ',' . finddir('node_modules', expand('%:p:h') . ';' . $HOME)

