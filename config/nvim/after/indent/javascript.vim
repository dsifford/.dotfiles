setlocal indentexpr=
setlocal cindent

let b:undo_indent = get(b:, 'undo_indent', '')

if !empty(b:undo_indent)
  let b:undo_indent .= '|'
endif

let b:undo_indent .= 'setlocal indentexpr< cindent<'
