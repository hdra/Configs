typeset -gA FX FG BG

FX=(
                                        none                         "\e[00m"
                                        normal                       "\e[22m"
  bold                      "\e[01m"    no-bold                      "\e[22m"
  faint                     "\e[02m"    no-faint                     "\e[22m"
  standout                  "\e[03m"    no-standout                  "\e[23m"
  underline                 "\e[04m"    no-underline                 "\e[24m"
  blink                     "\e[05m"    no-blink                     "\e[25m"
  fast-blink                "\e[06m"    no-fast-blink                "\e[25m"
  reverse                   "\e[07m"    no-reverse                   "\e[27m"
  conceal                   "\e[08m"    no-conceal                   "\e[28m"
  strikethrough             "\e[09m"    no-strikethrough             "\e[29m"
  gothic                    "\e[20m"    no-gothic                    "\e[22m"
  double-underline          "\e[21m"    no-double-underline          "\e[22m"
  proportional              "\e[26m"    no-proportional              "\e[50m"
  overline                  "\e[53m"    no-overline                  "\e[55m"

                                        no-border                    "\e[54m"
  border-rectangle          "\e[51m"    no-border-rectangle          "\e[54m"
  border-circle             "\e[52m"    no-border-circle             "\e[54m"

                                        no-ideogram-marking          "\e[65m"
  underline-or-right        "\e[60m"    no-underline-or-right        "\e[65m"
  double-underline-or-right "\e[61m"    no-double-underline-or-right "\e[65m"
  overline-or-left          "\e[62m"    no-overline-or-left          "\e[65m"
  double-overline-or-left   "\e[63m"    no-double-overline-or-left   "\e[65m"
  stress                    "\e[64m"    no-stress                    "\e[65m"

                                        font-default                 "\e[10m"
  font-first                "\e[11m"    no-font-first                "\e[10m"
  font-second               "\e[12m"    no-font-second               "\e[10m"
  font-third                "\e[13m"    no-font-third                "\e[10m"
  font-fourth               "\e[14m"    no-font-fourth               "\e[10m"
  font-fifth                "\e[15m"    no-font-fifth                "\e[10m"
  font-sixth                "\e[16m"    no-font-sixth                "\e[10m"
  font-seventh              "\e[17m"    no-font-seventh              "\e[10m"
  font-eigth                "\e[18m"    no-font-eigth                "\e[10m"
  font-ninth                "\e[19m"    no-font-ninth                "\e[10m"
)

FG[none]="$FX[none]"
BG[none]="$FX[none]"
colors=(black red green yellow blue magenta cyan white)
for color in {0..255}; do
  if (( $color >= 0 )) && (( $color < $#colors )); then
    index=$(( $color + 1 ))
    FG[$colors[$index]]="\e[38;5;${color}m"
    BG[$colors[$index]]="\e[48;5;${color}m"
  fi

  FG[$color]="\e[38;5;${color}m"
  BG[$color]="\e[48;5;${color}m"
done
unset color{s,} index


# ls
if is-callable 'dircolors'; then
  # GNU Core Utilities
  alias ls='ls --group-directories-first'

  if [[ -s "$HOME/.dir_colors" ]]; then
    eval "$(dircolors --sh "$HOME/.dir_colors")"
  else
    eval "$(dircolors --sh)"
  fi

  alias ls="${aliases[ls]:-ls} --color=auto"
else
  # BSD Core Utilities
  # Define colors for BSD ls.
  export LSCOLORS='exfxcxdxbxGxDxabagacad'

  # Define colors for the completion system.
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

  alias ls="${aliases[ls]:-ls} -G"
fi

# Grep
export GREP_COLOR='37;45'           # BSD.
export GREP_COLORS="mt=$GREP_COLOR" # GNU.
alias grep="${aliases[grep]:-grep} --color=auto"

# From https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/spectrum.zsh#L22
# Show all 256 colors with color number
ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}

function spectrum_ls() {
  for code in {0..255}; do
    print -P -- "$code: %{$FG[$code]%}$ZSH_SPECTRUM_TEXT%f"
  done
}

# Show all 256 colors where the background is set to specific color
function spectrum_bls() {
  for code in {0..255}; do
    print -P -- "$code: %{$BG[$code]%}$ZSH_SPECTRUM_TEXT%b"
  done
}

