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
export PATH=/usr/bin:/usr/sbin:/sbin/$PATH
export PATH=$HOME/.npm-global/bin:$PATH
export PATH=$HOME/.bin:$PATH
export PATH=$HOME/.brew/bin:$PATH
export PATH=$HOME/.brew/sbin:$PATH
export PATH=$HOME/.bin/platform-tools:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.mix/escripts:$PATH
export PATH=$PATH:$HOME/.composer/vendor/bin:/usr/local/php5/bin
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin:/usr/local/mysql/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$HOME/Tools/flutter/bin:$PATH
export PATH=$HOME/.serverless/bin:$PATH
export PATH=$PATH:/Applications/WezTerm.app/Contents/MacOS
export PATH="/Users/hndr/Library/Python/3.9/bin:$PATH"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/hndr/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

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

export KUBECONFIG=$HOME/kubeclusters/linode.yaml

test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

# export DOCKER_HOST=tcp://192.168.99.100:2376
# export DOCKER_CERT_PATH=$HOME/.docker/machine/machines/dinghy
# export DOCKER_TLS_VERIFY=1
# export DOCKER_MACHINE_NAME=dinghy


# local envs - meant to be excluded from git - stores machine-specific envs
LOCAL_ENV_FILE="$HOME/.local_env"
if [[ -f "$LOCAL_ENV_FILE" ]]; then
  source "$LOCAL_ENV_FILE"
fi
