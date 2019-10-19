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

alias g="git"
alias gaa="git add -A"
alias gst="git status"
alias gl="git pull"
alias gp="git push"
alias gcm="git commit -m"
alias gam="git commit -am"
alias gd="git diff"
alias gnuke="git reset --hard && git clean -df"

# Works shortcuts
alias gtd="git log --since="6am" --author='$GIT_AUTHOR' --oneline --no-merges | sed -e 's/^[a-z0-9]\{7\} //' | sed '/commit/d' | sed -e 's/^\([a-zA-Z0-9]\)/ - \1/' | tr -d '\n' | sed 's/\([a-zA-Z0-9]\)-\([a-zA-Z0-9]\)/\1_\2/' | tr '-' '\n' | sed -e '/^ $/d' | sed 's/^ /- /'"

alias ll="ls -lh"
alias la="ll -A"
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias sl='ls'            # I often screw this up.

alias less="less -R"  #color

alias ydl="noglob youtube-dl"
alias resetdns="dscacheutil -flushcache"
alias epoch="date +%s"
alias httpHere="python -m SimpleHTTPServer"

alias vi="vim"
alias vim="nvim"
alias tmx="tmux"
alias runs="reattach-to-user-namespace"

function daynote(){
 vim $(date +%Y-%m-%d).md
}

# Git ignore generator
function gi() {
  curl -L -s https://www.gitignore.io/api/$@
}

function with_env() {
  eval $(egrep -v '^#' $1 | xargs) ${@:2}
}

function install_subl() {
  ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl $HOME/.local/bin/subl
}

# Run docker volume create pgdata previously
alias dockerrun_pg="docker run -d \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_USER=postgres \
  -v /Users/hndr/Data/postgres:/var/lib/postgresql/data \
  postgres:10"


alias dockerrun_mysql="docker run -d \
  -v /Users/hndr/Data/mysql:/var/lib/mysql \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=true \
  -p 3306:3306 \
  mysql:5.7 --sql-mode='NO_ENGINE_SUBSTITUTION'"


#FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#Kiex
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"
