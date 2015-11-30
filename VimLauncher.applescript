on run {input, parameters}
    
    if (count of input) > 0 then
        tell application "System Events"
            set runs to false
            try
                set p to application process "iTerm"
                set runs to true
            end try
        end tell
    end if
    
    set numItems to count of items of input
    set launchPaths to ""
    
    tell application "iTerm"
        activate
        make new terminal
        tell current terminal
            tell (launch session "Default")
                repeat with x from 1 to numItems
                    set filePath to quoted form of POSIX path of item x of input
                    set launchPaths to launchPaths & " " & filePath
                end repeat
                write text ("vim " & launchPaths & " ; exit \n")
            end tell
        end tell

    end tell
    
    return input
end run
