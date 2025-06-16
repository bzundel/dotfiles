export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="cora-half-life"

plugins=(git)

eval "$(direnv hook zsh)"

source $ZSH/oh-my-zsh.sh

alias r=". ranger"
alias mp3d="yt-dlp -x --audio-format mp3 --embed-metadata --embed-thumbnail"
alias c="vdirsyncer sync && ikhal && vdirsyncer sync"
alias mail="offlineimap && mutt"

export PATH="$PATH:/home/bened/.dotnet/tools"
export EDITOR="vim"
