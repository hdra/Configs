#Collection of configs for a nice ZSH default
if [[ -s "${HOME}/.dotfiles/zsh/init.zsh" ]]; then
  source "${HOME}/.dotfiles/zsh/init.zsh"
fi

if [ -f /usr/local/bin/virtualenvwrapper_lazy.sh ]; then
    # virtualenvwrapper setup
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
    export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper_lazy.sh
fi

# chruby setup
if [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
    source /usr/local/opt/chruby/share/chruby/chruby.sh
    # enable chruby autoswitching
    source /usr/local/opt/chruby/share/chruby/auto.sh
    # set default ruby
    chruby 2.2.2
fi

export TAG=`date +DEPLOYED-%F/%H%M`

alias arts="php artisan"
alias cda="composer dumpautoload"
alias pymanage="python manage.py"
daynote(){
 vim $(date +%Y-%m-%d).md
}

alias gaa="git add -A"
alias gst="git status"
alias gl="git pull"
alias gp="git push"
alias gcm="git commit -m"
alias gam="git commit -am"
alias gd="git diff"
alias gs="git status"

alias ll="ls -lh"
alias la="ls -lA"
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias sl='ls'            # I often screw this up.

alias ydl="noglob youtube-dl"
alias resetdns="dscacheutil -flushcache"
alias epoch="date +%s"
alias httpHere="python -m SimpleHTTPServer"

alias vi="vim"
#alias vim="nvim"
alias tmx="tmux"
alias runs="reattach-to-user-namespace"

# Works shortcuts
alias ac-status="ssh ac-prod-1 'sudo supervisorctl status'"
alias gtd="git log --since="6am" --author='$GIT_AUTHOR' --oneline --no-merges | sed -e 's/^[a-z0-9]\{7\} //' | sed '/commit/d' | sed -e 's/^\([a-zA-Z0-9]\)/ - \1/' | tr -d '\n' | sed 's/\([a-zA-Z0-9]\)-\([a-zA-Z0-9]\)/\1_\2/' | tr '-' '\n' | sed -e '/^ $/d' | sed 's/^ /- /'"

alias deploy_fallout="ssh Fallout-prod 'cd opskii && git pull && make compile'"
alias restart_fallout="ssh Fallout-prod 'sudo service opskii restart'"

# Git ignore generator
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

bindkey -e

# Automatically activate venv a `venv` directory is present on the current dir.
# Mostly used for tmux windows
if [ -d "venv" ] ; then
    source venv/bin/activate
fi

#FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#Kiex
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"
