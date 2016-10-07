on run argv
    tell application "Terminal"
        --do script "sudo nginx" in front window
        --do shell script "sudo nginx" with administrator privileges
        do shell script "open -a /Applications/Postgres.app/"

        set wsp to "/Users/batilc/Workspace/signalive/"
        
        tell application "Finder"
            set resolution to bounds of window of desktop
            set scrwidth to item 3 of resolution
            set scrheight to item 4 of resolution
        end tell
        
        set smwidth to scrwidth / 7
        set miniheight to (scrheight - 75) / 6
        set smheight to (scrheight - 75) / 3
        
        do script "open -a Terminal"
        delay 0.5
        do script "echo 'redis-server'" in front window
        set the bounds of the front window to {smwidth * 6, 0, smwidth * 7, miniheight}
        set the current settings of selected tab of front window to first settings set whose name is "Pictoria"
        do script "redis-server" in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true
        set custom title of front window to "Redis"
        
        do script "open -a Terminal"
        delay 0.5
        do script "echo 'rabbitmq-server'" in front window
        set the bounds of the front window to {smwidth * 6, miniheight, smwidth * 7, miniheight * 2}
        set the current settings of selected tab of front window to first settings set whose name is "Pictoria"
        do script "rabbitmq-server" in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true
        set custom title of front window to "Rabbit"
        
        do script "open -a Terminal"
        delay 0.5
        do script "echo 'elasticsearch'" in front window
        set the bounds of the front window to {smwidth * 6, miniheight * 2, smwidth * 7, miniheight * 3}
        set the current settings of selected tab of front window to first settings set whose name is "Pictoria"
        do script "elasticsearch" in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true
        set custom title of front window to "Elastic"
     

        delay 10


        do script "open -a Terminal"
        delay 0.5
        do script "echo 'plugins'" in front window
        set the bounds of the front window to {smwidth * 6, miniheight * 3, smwidth * 7, miniheight * 4}
        set the current settings of selected tab of front window to first settings set whose name is "Grass"
        do script "cd " & wsp & "plugins" in front window
        do script "npm start" in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true
        set custom title of front window to "Plugins"
        
        do script "open -a Terminal"
        delay 0.5
        do script "echo 'hello-api'" in front window
        set the bounds of the front window to {smwidth * 6, miniheight * 4, smwidth * 7, miniheight * 5}
        set the current settings of selected tab of front window to first settings set whose name is "Solid Colors"
        do script "cd " & wsp & "signalive-hello-api" in front window
        do script "npm start" in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true
        set custom title of front window to "Hello"

        do script "open -a Terminal"
        delay 0.5
        do script "echo 'connection-tracker'" in front window
        set the bounds of the front window to {smwidth * 6, miniheight * 5, smwidth * 7, miniheight * 6}
        set the current settings of selected tab of front window to first settings set whose name is "Man Page"
        do script "cd " & wsp & "connection-tracker-master" in front window
        do script "npm start" in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true
        set custom title of front window to "Connection Tracker"


        do script "open -a Terminal"
        delay 0.5
        do script "echo 'datasourcefetcher-master'" in front window
        set the bounds of the front window to {smwidth * 3, 0, smwidth * 4.5, smheight}
        set the current settings of selected tab of front window to first settings set whose name is "Homebrew"
        do script "cd " & wsp & "datasourcefetcher-master" in front window
        do script "npm start" in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true
        set custom title of front window to "Datasourcefetcher Master"

        do script "open -a Terminal"
        delay 0.5
        do script "echo 'channel-scheduler-master'" in front window
        set the current settings of selected tab of front window to first settings set whose name is "Pro"
        set the bounds of the front window to {smwidth * 4.5, 0, smwidth * 6, smheight}
        do script "cd " & wsp & "channel-scheduler-master" in front window
        do script "npm start" in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true
        set custom title of front window to "Channel Scheduler Master"

        
        do script "open -a Terminal"
        delay 0.5
        do script "echo 'media-worker'" in front window
        set the bounds of the front window to {smwidth * 3, smheight * 1, smwidth * 6, smheight * 2}
        set the current settings of selected tab of front window to first settings set whose name is "Silver Aerogel"
        do script "cd " & wsp & "media-worker" in front window
        do script "npm start"in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true
        set custom title of front window to "Media Worker"

        do script "open -a Terminal"
        delay 0.5
        do script "echo 'datasourcefetcher-worker'" in front window
        set the bounds of the front window to {smwidth * 3, smheight * 2, smwidth * 6, smheight * 3}
        set the current settings of selected tab of front window to first settings set whose name is "Ocean"
        do script "cd " & wsp & "datasourcefetcher-worker" in front window
        do script "npm start" in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true
        set custom title of front window to "Datasourcefetcher Worker"
        
        
        
        do script "open -a Terminal"
        delay 0.5
        do script "echo 'webapi-worker'" in front window
        set the bounds of the front window to {smwidth * 0, smheight * 0, smwidth * 3, smheight * 1}
        set the current settings of selected tab of front window to first settings set whose name is "Big Boy"
        do script "cd " & wsp & "webapi-worker" in front window
        do script "npm start" in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true
        set custom title of front window to "Webapi Worker"

        do script "open -a Terminal"
        delay 0.5
        do script "echo 'core-worker'" in front window
        set the bounds of the front window to {smwidth * 0, smheight * 1, smwidth * 3, smheight * 2}
        set the current settings of selected tab of front window to first settings set whose name is "Red Sands"
        do script "cd " & wsp & "core-worker" in front window
        do script "npm start" in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true
        set custom title of front window to "Core Worker"
        
        do script "open -a Terminal"
        delay 0.5
        do script "echo 'socket-worker'" in front window 
        set the bounds of the front window to {smwidth * 0, smheight * 2, smwidth * 3, smheight * 3}
        set the current settings of selected tab of front window to first settings set whose name is "Novel"
        do script "cd " & wsp & "socket-worker" in front window
        do script "npm start" in front window

        set title displays device name of current settings of front window to false
        set title displays shell path of current settings of front window to false
        set title displays window size of current settings of front window to false
        set title displays settings name of current settings of front window to false
        set title displays custom title of current settings of front window to true
        set custom title of front window to "Socket Worker"
    end tell

    tell application "Terminal"
        activate
        do script "sudo -k nginx"
        set nginxwindow to front window
        delay 5
        close nginxwindow
    end tell
end run