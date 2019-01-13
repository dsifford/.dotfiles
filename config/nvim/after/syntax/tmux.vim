syn match tmuxConditionSep /,/ contained
syn match tmuxIf /^%\(if\|elif\)\>/ nextgroup=tmuxCondition
syn region tmuxCondition matchgroup=tmuxConditionSep nextgroup=tmuxOperator start=/ #{/ end=/}$/ contains=tmuxOperator,tmuxFormatString,tmuxConditionSep,tmuxNumber oneline
syn match tmuxOperator /\(==:\|!=:\|?\)/
syn match tmuxEndif /^%\(else\|endif\)\>$/ skipwhite

hi link tmuxConditionSep Separator
hi link tmuxIf Keyword
hi link tmuxCondition String
hi link tmuxOperator Operator
hi link tmuxEndif keyword

hi link tmuxFormatString Constant
