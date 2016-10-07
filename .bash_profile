#1. Environment Configuration

#2. Terminal Shortcuts

#3. Bash UI

#4. Bash Settings





# ---------------------

# 1. ENVIRONMENT CONFIG

# ---------------------



export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$WEBOS_CLI_TV:$PATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8



# ---------------------

# 2. TERMINAL SHORTCUTS

# ---------------------                   



alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias edit='subl'
alias myip='curl ip.appspot.com'

alias git='/usr/bin/git'
alias git-gui='/usr/local/opt/git/libexec/git-core/git-gui'
alias gg='/usr/local/opt/git/libexec/git-core/git-gui'

alias showFiles='defaults write com.apple.finder AppleShowAllFiles -boolean true; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles -boolean false; killall Finder /System/Library/CorseServices/Finder.app'
alias gruntBuild='grunt production device prod; cd target/; cordova build ios; cd ..;'

alias fixFavorites='cd ~/Library/Preferences && sudo find com.apple.finder.plist* -exec rm {} \; && killall Finder'

alias signa-start='osascript /opt/signa-starter.scpt'
alias signa-debug-start='osascript /opt/signa-debugstarter.scpt'
alias signa-quit='osascript /opt/signa-quitter.scpt'

alias signa-setup='osascript /opt/signa-setup-start.scpt'
alias signa-stop='osascript /opt/signa-setup-stop.scpt'

alias signa-update='osascript /opt/signa-update.scpt'
alias signa-run='osascript /opt/signa-runner.scpt'

# ---------------------

# 3. BASH UI

# ---------------------

osascript /opt/terminal-color.scpt

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'


if [ -f /opt/.git-completion.bash ]; then
  . /opt/.git-completion.bash
fi



parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


export PS1="\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "



# ---------------------

# 4. BASH SETTINGS

# ---------------------


HISTFILESIZE=20000
