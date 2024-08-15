
function Run {
    param ($command)
    & Invoke-Expression $command
}

# Start all background jobs
Run komorebic start -c ~\.config\komorebic\komorebi.json
Run autohotkey.exe ~\.config\komorebic\komorebi.ahk