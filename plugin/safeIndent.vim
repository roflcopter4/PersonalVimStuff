
function! SafeIndent()

    if search('^\s\{2}\S', 'w')
        s%/\v^[ ]{2}(\S)/    \1/
    else
        return 0
    endif

    "while search('\v^(%(\s{4}){-})\s{2}(\S)', 'w')
        "s%/\v^(%(\s{4}){-})%(%(\s{2}(\S))|%(%(\s{2}){-}\s{2}(\S)))/\1    \2/
        "s%/\v^(\t{-})((\s{2}(\S))|((\s{2}){-}(\S)))/\1\t~/
        "s%/\v^(\t{-})\s{2}/\1\t/
    "endwhile
    let s:num = 1
    while search("\v^(([ ]{4}){s:num})\s{2}" 'w')
        s%/\v^(([ ]{4}){s:num})\s{2}/\1\    /
        let s:num = s:num + 1
    endwhile

endfunction
