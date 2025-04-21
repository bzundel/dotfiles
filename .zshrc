export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="cora-half-life"

plugins=(git)

eval "$(direnv hook zsh)"

source $ZSH/oh-my-zsh.sh

alias r=". ranger"

export PATH="$PATH:/home/bened/.dotnet/tools"

