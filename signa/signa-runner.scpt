global smwidth
global miniheight
global smheight
global debug
global debugDeep
global alone
global helper


on showHelp()
    log "--------Signa Run Script Guide-------"
    log "options:"
    log "-d, --debug: Set environment variable DEBUG='repo:*'"
    log "-e, -p, --deep: Set environement variable to DEBUG='*'. Only works if debug is set!"
    log "-a, --alone: Do not run infrastracture repos or services like redis, elastic etc..."
    log ""
    log "----How to specify the repos to update----"
    log "Supply signa-run with repo names as params"
    log "Example: $ signa-run core web -de"
    log ""
    log "You may supply abbreviations as repo names"
    log ""
    log "core-worker: core, core-worker"
    log "webapi-worker: web, webapi, webapi-worker"
    log "socket-worker: sock, socket, socket-worker"
    log "media-worker: media, media-worker"
    log "channel-scheduler-master: sche, channel-scheduler-master"
    log "datasourcefetcher-master: dsmast, dsmaster, datasource-fetcher-master, fetcher-master"
    log "datasourcefetcher-worker: dswork, dsworker, datasourcefetcher-worker"
    log ""
    log ""
    log "---More Shortcuts---"
    log ""
    log "$ signa-update ''|full|all <options> : Run all the system workers/masters"
    log ""
    log "------End of Help------"

end showHelp


on getColor(name)
    if name is in {"datasourcefetcher-master"}
        return "Homebrew"
    else if name is in {"channel-scheduler-master"}
        return "Pro"
    else if name is in {"media-worker"}
        return "Silver Aerogel"
    else if name is in {"datasourcefetcher-worker"}
        return "Ocean"
    else if name is in {"webapi-worker"}
        return "Big Boy"
    else if name is in {"core-worker"}
        return "Red Sands"
    else if name is in {"socket-worker"}
        return "Novel"
    else
        return "unknown"
    end if
end getColor


on getRealName(abbreviation)
    if abbreviation is in {"dsmast", "dsmaster", "datasourcefetcher-master"}
        return "datasourcefetcher-master"
    else if abbreviation is in {"sche", "channel-scheduler-master"}
        return "channel-scheduler-master"
    else if abbreviation is in {"media", "media-worker"}
        return "media-worker"
    else if abbreviation is in {"dswork", "dsworker", "datasourcefetcher-worker"}
        return "datasourcefetcher-worker"
    else if abbreviation is in {"webapi", "web", "webapi-worker"}
        return "webapi-worker"
    else if abbreviation is in {"core", "core-worker"}
        return "core-worker"
    else if abbreviation is in {"sock", "socket", "socket-worker"}
        return "socket-worker"
    else
        return "unknown"
    end if
end getRealName


on getTitle(name)
    if name is in {"redis-server"}
        return "Redis"
    else if name is in {"rabbitmq-server"}
        return "Rabbit"
    else if name is in {"elasticsearch"}
        return "Elastic"
    else if name is in {"plugins"}
        return "Plugins"
    else if name is in {"signalive-hello-api"}
        return "Hello"
    else if name is in {"connection-tracker-master"}
        return "Connection Tracker"
    else if name is in {"datasourcefetcher-master"}
        return "Datasourcefetcher Master"
    else if name is in {"channel-scheduler-master"}
        return "Channel Scheduler Master"
    else if name is in {"media-worker"}
        return "Media Worker"
    else if name is in {"datasourcefetcher-worker"}
        return "Datasourcefetcher Worker"
    else if name is in {"webapi-worker"}
        return "Webapi Worker"
    else if name is in {"core-worker"}
        return "Core Worker"
    else if name is in {"socket-worker"}
        return "Socket Worker"
    else
        return "unknown"
    end if
end getTitle


on getBounds(name)
    if name is in {"redis-server"}
        return {smwidth * 6, 0, smwidth * 7, miniheight}
    else if name is in {"rabbitmq-server"}
        return {smwidth * 6, miniheight, smwidth * 7, miniheight * 2}
    else if name is in {"elasticsearch"}
        return {smwidth * 6, miniheight * 2, smwidth * 7, miniheight * 3}
    else if name is in {"plugins"}
        return {smwidth * 6, miniheight * 3, smwidth * 7, miniheight * 4}
    else if name is in {"signalive-hello-api"}
        return {smwidth * 6, miniheight * 4, smwidth * 7, miniheight * 5}
    else if name is in {"connection-tracker-master"}
        return {smwidth * 6, miniheight * 5, smwidth * 7, miniheight * 6}
    else if name is in {"datasourcefetcher-master"}
        return {smwidth * 3, 0, smwidth * 4.5, smheight}
    else if name is in {"channel-scheduler-master"}
        return {smwidth * 4.5, 0, smwidth * 6, smheight}
    else if name is in {"media-worker"}
        return {smwidth * 3, smheight * 1, smwidth * 6, smheight * 2}
    else if name is in {"datasourcefetcher-worker"}
        return {smwidth * 3, smheight * 2, smwidth * 6, smheight * 3}
    else if name is in {"webapi-worker"}
        return {smwidth * 0, smheight * 0, smwidth * 3, smheight * 1}
    else if name is in {"core-worker"}
        return {smwidth * 0, smheight * 1, smwidth * 3, smheight * 2}
    else if name is in {"socket-worker"}
        return {smwidth * 0, smheight * 2, smwidth * 3, smheight * 3}
    end if
        return {0, 0, 0, 0}
end getBounds



on runService(serviceName, colorName)
    set title to getTitle(serviceName)
    set bound to getBounds(serviceName)
    
    tell application "Terminal"
        do script "open -a Terminal"
        delay 0.5
        do script "echo " & serviceName in front window
        set the bounds of the front window to bound
        set the current settings of selected tab of front window to first settings set whose name is colorName
        do script serviceName in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true

        set custom title of front window to title
    end tell
end runService


on runRepo(repoName, colorName)
    set title to getTitle(repoName)
    set bound to getBounds(repoName)
    set wsp to "/Users/batilc/Workspace/signalive/"
    set debugger to ""

    if debug
        if debugDeep
            set debugger to "*"
        else
            set debugger to repoName & ":*"
        end if 
    end if

    tell application "Terminal"
        do script "open -a Terminal"
        delay 0.5
        do script "echo " & repoName in front window
        set the bounds of the front window to bound
        set the current settings of selected tab of front window to first settings set whose name is colorName
        do script "cd " & wsp & repoName in front window
        do script "DEBUG='" & debugger & "' npm start" in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true

        set custom title of front window to title
    end tell
end runRepo


on run argv
    set wsp to "/Users/batilc/Workspace/signalive/"
    
    local abbreviations
    set repos to {}
    set debug to false
    set debugDeep to false
    set alone to false
    set helper to false

    repeat with arg in argv
        if arg begins with "-"
            local flags
            if arg begins with "--"
                set flags to {characters 3 thru end of arg as string}
            else
                set flags to characters 2 thru end of arg
            end if

            repeat with flag in flags
                if flag is in {"d", "debug"}
                    set debug to true
                else if flag is in {"e", "p", "deep"}
                    set debugDeep to true
                else if flag is in {"a", "alone"}
                    set alone to true
                else if flag is in {"h", "help"}
                    set helper to true
                end if
            end repeat

        else 
            copy arg as string to the end of repos
        end if
    end repeat

    if not debug
        set debugDeep to false
    end if

    if helper
        showHelp()
        return
    end if

    set params to count of repos
    if params is equal to 0 or "full" is in repos or "all" is in repos
        set abbreviations to {"core", "web", "socket", "media", "sche", "dsmast", "dswork"}
    else
        set abbreviations to repos
    end if

    log ""
    log "-------------------------------------"
    log "Starting runner script with following flags:"
    log "-------------------------------------"
    log "Debug: " & debug
    log "Debug Deep: " & debugDeep
    log ""

    set repolog to {}
    repeat with abbr in abbreviations
        set myname to getRealName(abbr)
        if myname is not equal to "unknown"
            copy myname to the end of repolog
        end if
    end repeat

    if count of repolog is greater than 0
        log "-------------------------------------"
        log "Going to launch Postgres, Redis, Rabbit, Elastic"
        log "Will wait for 10 seconds to have services up & running"
        log "After that will launch Plugins, Hello-API and Conn. Tracker"
        log "Then will run: "
        log "-------"
        log repolog
        log "-------"
        log "Lastly, will start nginx"
    else
        log "-------------------------------------"
        log "No signa repo is supplied for running!"
        log "Terminating..."
        return
    end if


    tell application "Finder"
        set resolution to bounds of window of desktop
        set scrwidth to item 3 of resolution
        set scrheight to item 4 of resolution
    end tell
    
    set smwidth to scrwidth / 7
    set miniheight to (scrheight - 75) / 6
    set smheight to (scrheight - 75) / 3


    local initiator 
    tell application "Terminal"
        set initiator to front window
    end tell

    if not alone    
        do shell script "open -a /Applications/Postgres.app/"

        runService("redis-server", "Pictoria")
        runService("rabbitmq-server", "Pictoria")
        runService("elasticsearch", "Pictoria")

        delay 10

        runRepo("plugins", "Grass")
        runRepo("signalive-hello-api", "Solid Colors")
        runRepo("connection-tracker-master", "Man Page")
    end if


    repeat with abbreviation in abbreviations
        set repoName to getRealName(abbreviation)

        if repoName is not equal to "unknown"
            set repoColor to getColor(repoName)
            runRepo(repoName, repoColor)
        end if
    end repeat

    if not alone
        tell application "Terminal"
            activate
            do script "sudo -k nginx"
            set nginxwindow to front window
            delay 5
            close nginxwindow
        end tell
    end if
end run