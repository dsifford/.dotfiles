runtime! ftplugin/typescript.vim

if expand('%:t:r') =~# '[-.]test$'
    UltiSnipsAddFiletypes jest.tsx.typescript
else
    UltiSnipsAddFiletypes tsx.typescript
endif
