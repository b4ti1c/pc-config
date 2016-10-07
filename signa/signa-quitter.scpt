on closePrompt()
    tell application "System Events"
        key code 36
    end tell
end closePrompt

on closeWindow(windowtitle)
    delay 0.5
    tell application "Terminal"
        set winlist to every window
        set found to false
        repeat with win in winlist
            if windowtitle is equal to (custom title of win) then
                set found to true
                activate
                close win
            end if
        end repeat
    end tell
    if found then
        closePrompt()
    end if
end closeWindow

on run argv
    closeWindow("Plugins")
    closeWindow("Hello")
    closeWindow("Connection Tracker")
    closeWindow("Datasourcefetcher Master")
    closeWindow("Datasourcefetcher Worker")
    closeWindow("Channel Scheduler Master")
    closeWindow("Core Worker")
    closeWindow("Webapi Worker")
    closeWindow("Socket Worker")
    closeWindow("Media Worker")

    closeWindow("Redis")
    closeWindow("Rabbit")
    closeWindow("Elastic")

    tell application "Postgres"
        quit
    end tell

    tell application "Terminal"
        activate
        do script "sudo -k nginx -s stop"
        set nginxwindow to front window
        delay 5
        close nginxwindow
    end tell

    do shell script "redis-cli shutdown"
    
end run