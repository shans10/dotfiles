"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" " Function for bold highlights " """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Call this with something like
"
""" :AddBoldToGroup perlRepeat

command! -complete=highlight -nargs=1 AddBoldToGroup call AddBoldToGroup(<f-args>)
function! AddBoldToGroup(group)
    " Redirect the output of the "hi" command into a variable
    " and find the highlighting
    redir => GroupDetails
    exe "silent hi " . a:group
    redir END

    " Resolve linked groups to find the root highlighting scheme
    while GroupDetails =~ "links to"
        let index = stridx(GroupDetails, "links to") + len("links to")
        let LinkedGroup =  strpart(GroupDetails, index + 1)
        redir => GroupDetails
        exe "silent hi " . LinkedGroup
        redir END
    endwhile

    " Extract the highlighting details (the bit after "xxx")
    let MatchGroups = matchlist(GroupDetails, '\<xxx\>\s\+\(.*\)')
    let ExistingHighlight = MatchGroups[1]

    " Check whether there's an existing gui= block
    let MatchGroups = matchlist(ExistingHighlight, '^\(.\{-}\) gui=\([^ ]\+\)\( .\{-}\)\?$')
    if MatchGroups != []
        " If there is, check whether "bold" is already in it
        let StartHighlight = MatchGroups[1]
        let GuiHighlight = MatchGroups[2]
        let EndHighlight = MatchGroups[3]
        if GuiHighlight =~ '.*bold.*'
            " Already done
            return
        endif
        " Add "bold" to the gui block
        let GuiHighlight .= ',bold'
        let NewHighlight = StartHighlight . GuiHighlight . EndHighlight
    else
        " If there's no GUI block, just add one with bold in it
        let NewHighlight = ExistingHighlight . " gui=bold"
    endif

    " Create the highlighting group
    exe "hi " . a:group . " " NewHighlight
endfunction

" Bold Groups
AddBoldToGroup Type
AddBoldToGroup PreProc
AddBoldToGroup Statement
AddBoldToGroup Conditional
AddBoldToGroup Include
AddBoldToGroup Define
AddBoldToGroup Macro
AddBoldToGroup Typedef
AddBoldToGroup Function
AddBoldToGroup Structure
AddBoldToGroup Repeat
AddBoldToGroup CursorLineNr
AddBoldToGroup Label
AddBoldToGroup StatusLineNC
AddBoldToGroup VertSplit
AddBoldToGroup Folded
AddBoldToGroup Title
AddBoldToGroup ErrorMsg
AddBoldToGroup DiffText
AddBoldToGroup Comment
AddBoldToGroup String
AddBoldToGroup Todo
AddBoldToGroup Operator
AddBoldToGroup Constant
AddBoldToGroup Boolean
AddBoldToGroup SignifySignAdd
AddBoldToGroup SignifySignChange
AddBoldToGroup SignifySignDelete

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" " END " """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
