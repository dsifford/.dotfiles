" Vim syntax file
" Language: GitHub Pull Request
" Maintainer: Derek Sifford <dereksifford@gmail.com>
" Filenames: *.git/PULLREQ_EDITMSG
" Latest Revision: 2018 Oct 30

if exists('b:current_syntax')
    finish
endif

syn match pullrequestFirstLine "\%^[^#].*"  nextgroup=pullrequestBlank skipnl
syn match pullrequestSummary   "^.\{0,50\}" contained                  containedin=pullrequestFirstLine nextgroup=pullrequestOverflow contains=@Spell
syn match pullrequestOverflow  ".*"         contained                  contains=@Spell
syn match pullrequestBlank     "^[^#].*"    contained                  contains=@Spell

syn region pullrequestMetadata start="^# [-]* >8 [-]*$" end="\%$"

hi def link pullrequestSummary Keyword
hi def link pullrequestBlank  Error
hi def link pullrequestMetadata Comment

let b:current_syntax = 'gitpullrequest'
