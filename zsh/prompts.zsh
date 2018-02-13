fpath=("${HOME}/.dotfiles/zsh/prompts" $fpath)

autoload -Uz promptinit && promptinit
#Prevent pure from doing remote check
PURE_GIT_PULL=0
PURE_PROMPT_SYMBOL="❯❯"
PURE_GIT_UP_ARROW="▲"
PURE_GIT_DOWN_ARROW="▼"
prompt pure
