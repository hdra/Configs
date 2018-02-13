fpath=("${HOME}/.dotfiles/zsh/prompts" $fpath)

autoload -Uz promptinit && promptinit
#Prevent pure from doing remote check
PURE_GIT_PULL=0
prompt pure
