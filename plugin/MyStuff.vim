" File: MyStuff.vim 
" Maintainer: Me
" Version: 0.1
" Description: Doesn't work
" Location: plugin/numbers.vim

function AddSpaces()
    execute "2"
    let a:line_number = 2
    try
        while a:line_number > 0
            let a:line_number = search('^$', 'W')
            let a:num_spaces = indent(a:line_number - 1)
            if a:num_spaces > 0
                let a:line_string = repeat(' ', a:num_spaces + 1)
                call setline(a:line_number, a:line_string)
                echo "Setting line " a:line_number " to have " a:num_spaces+1 " spaces."
            else
                execute "+"
            endif
        endwhile
        
    catch /^Vim\%((\a\+)\)\=:E/
        echo "DONE"
    endtry
endfunction

command! -nargs=0 AddSpaces call AddSpaces()

