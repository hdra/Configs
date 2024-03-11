
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

#
# Temporary Files
#

TMPPREFIX="$(mktemp -d)/zsh"

if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -f "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

##
# Your previous /Users/hndr/.zprofile file was backed up as /Users/hndr/.zprofile.macports-saved_2023-11-27_at_15:40:57
##

# MacPorts Installer addition on 2023-11-27_at_15:40:57: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

