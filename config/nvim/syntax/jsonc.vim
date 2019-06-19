if exists('b:current_syntax') && b:current_syntax ==# 'jsonc'
  finish
endif

runtime! syntax/json.vim

syntax keyword jsonCommentTodo    contained TODO FIXME XXX
syntax region  jsonComment        start=+//+ end=/$/ contains=jsonCommentTodo,@Spell extend keepend
syntax region  jsonComment        start=+/\*+  end=+\*/+ contains=jsonCommentTodo,@Spell fold extend keepend

hi! link jsonComment      Comment
hi! link jsonCommentError Comment
hi! link jsonCommentTodo  Todo

if !exists('b:current_syntax')
  let b:current_syntax = 'jsonc'
endif
