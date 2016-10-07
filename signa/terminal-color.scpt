on run argv
    tell application "Terminal"
	if number of tabs of front window = 1 then
  	    set defaultThemeOffset to 6
	    set allThemes to number of settings set
	    set allThemes to allThemes + 1
      	    set allWindows to number of windows
	    set themeIndex to (defaultThemeOffset + allWindows) mod allThemes
	    set current settings of selected tab of front window to settings set themeIndex
	end if
    end tell
end run
