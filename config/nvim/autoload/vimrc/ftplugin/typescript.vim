" Transforms a selected range of JSDoc into TSDoc
func! vimrc#ftplugin#typescript#tsdocify() range
    let l:rng = a:firstline . ',' . a:lastline

    " fix params
    silent! exec l:rng . 's/\v(* \@param) +\{.+\} +(\w+) *(\S.*)?/\1 \2 - \3/'

    " fix optional params
    silent! exec l:rng . 's/\v(* \@param) +\{.+\} +\[ *(\w+)%(\=.*)?\]%( +(.*))?/\1 \2 - \3/'

    " fix trailing `-` in params without descriptions
    silent! exec l:rng . 's/\v(* \@param \w*) - $/\1/'

    " fix return statements
    silent! exec l:rng . 's/\v* \@returns? +\{.*\} *(.*)/* @returns \1/'
endfunc
