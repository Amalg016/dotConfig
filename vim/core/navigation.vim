
command! FindFiles call FindFiles()
command! GrepText call GrepText()

function! FindFiles()
    " Prompt the user to enter a file pattern
    let pattern = input('Grep fileName: ')
    
    " Run the find command with the user-provided pattern and capture its output
    let files = systemlist('find . -type f -name "*' . pattern . '*"')

    " Initialize an empty quickfix list
    let qf_list = []

    " Iterate over the captured files and add them to the quickfix list
    for file in files
        call add(qf_list, {'filename': file})
    endfor

    " Set the quickfix list with the parsed output
    call setqflist(qf_list)

    " Open the quickfix window to view the results
    copen
endfunction

function! GrepText()
    " Prompt the user to enter a file pattern
    let pattern1 = input('fileType: ')
    let pattern2 = input('Grep Text: ')
    " Run the find command with the user-provided pattern and capture its output
    let files = systemlist(' grep --include="*.'.. pattern1 .. '" -nRHI "'.. pattern2 ..'" * | awk -F ":" "{print $1}"')

    " Initialize an empty quickfix list
    let qf_list = []

    " Iterate over the captured files and add them to the quickfix list
    for file in files
        let arr = split(file,":")
        let path = arr[0] 
        call add(qf_list, {'filename': path,'lnum': arr[1], 'col': 1,'text': file})
    endfor

    " Set the quickfix list with the parsed output
    call setqflist(qf_list)

    " Open the quickfix window to view the results
    copen
endfunction
