# Since .zshenv is always sourced, it often contains exported variables
# that should be available to other programs.
# For example, $PATH, $EDITOR, and $PAGER are often set in .zshenv.
#
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Weird python on OS X fix
export LC_ALL=en_US.UTF-8

#Golang
export GOPATH=$HOME/GoCode

# Android SDK
export ANDROID_HOME=$HOME/Library/Android/sdk

# N
export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# First place too look for path
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$HOME/.npm-global/bin:$PATH
export PATH=$HOME/.bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$HOME/.composer/vendor/bin:/usr/local/php5/bin
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin:/usr/local/mysql/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools

# Git
export GIT_AUTHOR=Hendra

# Editors
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

#Mysql libs path
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

#IEX Shell history
export ERL_AFLAGS="-kernel shell_history enabled"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home
