global remainFlag
global pullFlag
global installFlag
global buildFlag
global helpFlag
global wsp
global rel


on showHelp()
    log "--------Signa Update Script Guide-------"
    log "options:"
    log "-p, --nopull: Do not pull (&rebase) your current & master branch"
    log "-r, --remain: After rebasing your local master, rebase your current branch and leave it as current working branch. If this option is not supplied, the repo is left at master branch"
    log "-i, --install: Do an npm/bower install after rebase."
    log "-b, --build: Do grunt/gulp dev after rebase or install phase. Only works for app and panel"
    log ""
    log "----How to specify the repos to update----"
    log "Supply signa-update with repo names as params"
    log "Example: $ signa-update core-worker microservice-kit -r"
    log ""
    log "You can supply various abbreviations as repo names"
    log ""
    log "core-worker: core, core-worker"
    log "webapi-worker: webapi, webapi-worker"
    log "socket-worker: socket, socket-worker"
    log "media-worker: media, media-worker"
    log "channel-scheduler-master: sche, sched, scheduler, channel-scheduler, channel, chan"
    log "datasourcefetcher-master: dsmast, dsmaster, datasource-master, datasourcefetcher-master, datasource-fetcher-master, fetcher-master"
    log "datasourcefetcher-worker: dswork, dsworker, datasource-worker, datasourcefetcher-worker, datasource-fetcher-worker, fetcher-worker"
    log "connection-tracker-master: track, conn, tracker, connection, connection-tracker, connection-tracker-master"
    log "signalive-hello-api: hello, helloapi, hello-api"
    log "plugins: plug, plugins"
    log "microservice-kit: kit, micro, microkit, servicekit, microservice-kit, microservicekit"
    log "microservice-kit-enums: kiten, kitenum, kit-enum, microenum, micro-enum, microkit-enum, microservice-kit-enums, microservicekit-enums"
    log "administration: admin, administer, administration"
    log "static-storage: stor, store, stora, storage, static-storage"
    log "app: app"
    log "panel: panel"
    log "signalive-serial-scap-daemon: daemon, demon, ssdaemon, serial-daemon, serial-scap-daemon"
    log "weinre: wein, weinre"
    log ""
    log ""
    log "---More Shortcuts---"
    log ""
    log "$ signa-update <options> : Update only workers, masters, hello and plugins"
    log ""
    log "$ signa-update fe|frontend|client|clientside|front <options> : Update only app, panel and plugins"
    log ""
    log "$ signa-update full|all <options> : Update all of the repos above"
    log ""
    log "------End of Help------"

end showHelp


on getRepoName(abbreviation)
    set repoName to "unknown"

    if abbreviation is in {"core", "core-worker"}
        set repoName to "core-worker"
    
    else if abbreviation is in {"web", "webapi", "webapi-worker"}
        set repoName to "webapi-worker"

    else if abbreviation is in {"socket", "socket-worker"}
        set repoName to "socket-worker"

    else if abbreviation is in {"media", "media-worker"}
        set repoName to "media-worker"

    else if abbreviation is in {"sche", "sched", "scheduler", "channel-scheduler", "channel", "chan"}
        set repoName to "channel-scheduler-master"

    else if abbreviation is in {"dsmast", "dsmaster", "datasource-master", "datasourcefetcher-master", "datasource-fetcher-master", "fetcher-master"}
        set repoName to "datasourcefetcher-master"

    else if abbreviation is in {"dswork", "dsworker", "datasource-worker", "datasourcefetcher-worker", "datasource-fetcher-worker", "fetcher-worker"}
        set repoName to "datasourcefetcher-worker"

    else if abbreviation is in {"track", "conn", "tracker", "connection", "connection-tracker", "connection-tracker-master"}
        set repoName to "connection-tracker-master"

    else if abbreviation is in {"hello", "helloapi", "hello-api"}
        set repoName to "signalive-hello-api"

    else if abbreviation is in {"plug", "plugins"}
        set repoName to "plugins"



    else if abbreviation is in {"kit", "micro", "microkit", "servicekit", "microservice-kit", "microservicekit"}
        set repoName to "microservice-kit"

    else if abbreviation is in {"kiten", "kitenum", "kit-enum", "microenum", "micro-enum", "microkit-enum", "microservice-kit-enums", "microservicekit-enums"}
        set repoName to "microservice-kit-enums"

    else if abbreviation is in {"admin", "administer", "administration"}
        set repoName to "administration"

    else if abbreviation is in {"stor", "store", "stora", "storage", "static-storage"}
        set repoName to "static-storage"

    else if abbreviation is in {"app"}
        set repoName to "app"

    else if abbreviation is in {"panel"}
        set repoName to "panel"

    else if abbreviation is in {"daemon", "demon", "ssdaemon", "serial-daemon", "serial-scap-daemon"}
        set repoName to "signalive-serial-scap-daemon"

    else if abbreviation is in {"wein", "weinre"}
        set repoName to "weinre"

    end if

    return repoName
end getRepoName


on getFullPath(repoName)
    set wsp to "/Users/batilc/Workspace/signalive/"
    set rel to "other/"
    set dir to "unknown"

    if repoName is in {"core-worker", "webapi-worker", "socket-worker", "media-worker", "channel-scheduler-master", "datasourcefetcher-master", "datasourcefetcher-worker", "connection-tracker-master", "microservice-kit", "microservice-kit-enums", "static-storage", "signalive-hello-api", "plugins", "app", "panel"}
        set dir to wsp & repoName
    else if repoName is in {"administration", "signalive-serial-scap-daemon", "weinre"}
        set dir to wsp & rel & repoName
    end if

    return dir
end getFullPath


on getGit(path)
    set git to "unknown"

    if path is not equal to "unknown"
        set git to "/usr/bin/git -C " & path & " "
    end if

    return git
end getGit


on pull(repo)
    set fullPath to getFullPath(repo)
    set git to getGit(fullPath)

    set repoName to do shell script git & "remote -v | head -n1 | awk '{print $2}' | sed 's/.*\\///' | sed 's/\\.git//'"
    log "Updating " & repoName
    
    set branch to do shell script git & "rev-parse --abbrev-ref HEAD"
    set stashResponse to do shell script git & "stash save"

    if stashResponse is not equal to "no local changes to save"
        log "Stashed your changes in " & repoName
    end if

    if branch is not equal to "master"
        log "Checking out master branch in " & repoName   
        do shell script git & "checkout master"
    end if

    log "Rebasing master branch in " & repoName
    do shell script git & "pull --rebase origin master"

    if remainFlag and branch is not equal to "master"
        log "Rebasing " & branch & " on up-to-date master in " & repoName

        try
            do shell script git & "checkout " & branch
            do shell script git & "rebase master"
        on error msg
            log "Conflict occured while rebasing " & branch & " to master in " & repoName
            log "Aborting rebase!"

            say "Conflict occured while rebasing " & branch & " to master in " & repoName using "Pipe Organ" speaking rate 500
            say "Aborting rebase!" using "Zarvox" speaking rate 300
            do shell script git & "rebase --abort"

            return
        end try
    end if

    if stashResponse is not equal to "no local changes to save"
        log "Applying back your stashed changes"
        do shell script git & "stash apply"
    end if

end pull


on install(repo)
    set fullPath to getFullPath(repo)
    set git to getGit(fullPath)
    set repoName to do shell script git & "remote -v | head -n1 | awk '{print $2}' | sed 's/.*\\///' | sed 's/\\.git//'"

    log "Running `npm install` in " & repoName
    do shell script "cd " & fullPath & " && npm install"

    if repoName is in {"app", "panel", "plugins"}
        log "Running `bower install` in " & repoName
        do shell script "cd " & fullPath & " && bower install"
    end if
end install


on build(repo)
    set fullPath to getFullPath(repo)
    set git to getGit(fullPath)
    set repoName to do shell script git & "remote -v | head -n1 | awk '{print $2}' | sed 's/.*\\///' | sed 's/\\.git//'"

    if repoName is equal to "signalive-app"
        log "Building app (`grunt dev`)"
        do shell script "cd " & fullPath & " && grunt dev"
    else if repoName is equal to "signalive-panel"
        log "Building panel (`gulp dev`)"
        do shell script "cd " & fullPath & " && gulp dev"
    end if
end build


on run argv
    log ""

    local abbreviations
    set repos to {}
    set remainFlag to false
    set pullFlag to true
    set installFlag to false
    set buildFlag to false
    set helpFlag to false

    repeat with arg in argv
        if arg begins with "-"
            local flags
            if arg begins with "--"
                set flags to {characters 3 thru end of arg as string}
            else
                set flags to characters 2 thru end of arg
            end if

            repeat with flag in flags
                if flag is in {"r", "remain"}
                    set remainFlag to true
                else if flag is in {"p", "nopull"}
                    set pullFlag to false
                else if flag is in {"b", "build"}
                    set buildFlag to true
                else if flag is in {"i", "install"}
                    set installFlag to true
                else if flag is in {"h", "help"}
                    set helpFlag to true
                end if
            end repeat

        else 
            copy arg as string to the end of repos
        end if

    end repeat

    if helpFlag
        showHelp()
        return
    end if

    log "-------------------------------------"
    log "Starting update script with following flags:"
    log "-------------------------------------"
    log "Pull: " & pullFlag
    log "Remain at current branch: " & remainFlag
    log "Deps Install: " & installFlag
    log "Build: " & buildFlag


    set params to count of repos
    if params is equal to 0
        set abbreviations to {"core", "webapi", "socket", "media", "sche", "dsmast", "dswork", "track", "hello", "plug"}
    else if "full" is in repos or "all" is in repos
        set abbreviations to {"core", "webapi", "socket", "media", "sche", "dsmast", "dswork", "track", "hello", "plug", "kit", "kiten", "admin", "stor", "app", "panel", "daemon", "wein"}
    else if "fe" is in repos or "frontend" is in repos or "client" is in repos or "front" is in repos
        set abbreviations to {"plug", "app", "panel"}
    else
        set abbreviations to repos
    end if

    set repolog to {}
    repeat with abbr in abbreviations
        set myname to getRepoName(abbr)
        if myname is not equal to "unknown"
            copy myname to the end of repolog
        end if
    end repeat

    if count of repolog is greater than 0
        log "-------------------------------------"
        log "Going to update following repos: "
        log repolog
    else
        log "-------------------------------------"
        log "No signa repo is supplied for update!"
        log "Terminating..."
        return
    end if

    log "--------------Run Phase---------------"
    repeat with abbreviation in abbreviations
        if abbreviation is not equal to "remain"
            set repo to getRepoName(abbreviation)

            if repo is not equal to "unknown"
                log "---Updating " & repo & "---"
                if pullFlag
                    pull(repo)
                end if
                if installFlag
                    install(repo)
                end if
                if buildFlag
                    build(repo)
                end if
            end if
        end if
    end repeat

    log "Job's Done!"

    set userName to short user name of (system info)
    say "Job's done" using "Pipe Organ"
    -- say "Job's done " & userName using "Pipe Organ"
end run