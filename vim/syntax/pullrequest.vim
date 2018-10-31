" Vim syntax file
" Language: Hub Pull Request
" Maintainer: Derek Sifford <dereksifford@gmail.com>
" Filenames: *.git/PULLREQ_EDITMSG
" Latest Revision: 2018 Oct 30

if exists('b:current_syntax')
    finish
endif

syn case match

syn include @Markdown syntax/markdown.vim

syn match pullreqBlank    contained "^.*"        contains=@Spell
syn match pullreqOverflow contained ".*"         contains=@Spell
syn match pullreqSummary  contained "^.\{0,50\}" contains=@Spell nextgroup=pullreqOverflow

syn region pullreqMessage   keepend start="^." end="^\ze# [-]* >8" contains=@Markdown,@Spell nextgroup=pullreqMetadata
syn region pullreqMetadata          start="^# [-]* >8 [-]*$" end="\%$"
syn match  pullreqFirstLine skipnl  "\%^[^#].*"  contains=pullreqSummary nextgroup=pullreqBlank

hi def link pullreqBlank    Error
hi def link pullreqMetadata Comment
hi def link pullreqSummary  Keyword

let b:current_syntax = 'pullrequest'
