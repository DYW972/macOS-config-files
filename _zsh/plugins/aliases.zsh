# NAVIGATION
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
# COMMON DIRECTORIES
alias pwdf="pwdf"
alias home="cd ~"
alias dt="cd ~/Desktop"
alias dl="cd ~/Downloads"
alias dcs="cd ~/Documents"
alias dev="cd ~/Developer"
# LIST FOLDERS OF FILES
alias ll="ls -alG"
# MANAGE FILES OR FOLDER
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
# GIT
alias gitinit="git init --template=/Users/dyw/.git_templates/"
alias glog="git log --oneline --color | emojify | less -r" # brew install emojify
# FIND MY IP ADDRESS
alias myip="curl https://ipecho.net/plain; echo"
# EASIER DOTFILE EDITING
alias zshaliases="$EDITOR ~/.aliases"
alias zshconfig="$EDITOR ~/.zshrc"
alias resetzsh="source $HOME/.zshrc"
# SHELL SCRIPTS
alias makeheader="cd $ZSH/library && zsh makeHeader.sh"
# SHOW/HIDE HIDDEN FILES
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
alias showhidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
# SHOW/HIDE DESKTOP ICONS
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
# DARK MODE	
alias darkmode="~/.zsh/library/dark-mode"
# SECURITY
alias sha1='shasum -a'
alias sha256='shasum -a 256'
# MAN PAGE
alias xman="xmanpage"
alias pdfman="premanpage"
# OTHERS
alias revopt="emulate -LR zsh"
alias rebuildzcompdump="rm ~/.zcompdump && compinit"
alias reveal='open -R'
alias xcode='open -a Xcode'
