# custom battery script
alias power=~/scripts/other/getpower.sh

alias whatismyip='curl http://ipecho.net/plain; echo'

alias watch='watch '

# remove spell checking
alias vim='vim -c "set nospell"'

# useful tmux aliases
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'
alias tl='tmux ls'
alias tn='tmux new-session'
alias attach='tmux attach'

# for use with usb tethering.
alias hotspot='sudo ifconfig usb0 up && sudo dhclient usb0'

# environmentals
export GITHUB=~/projects
export SCRIPTS=~/scripts
export BUILDFILE=~/scripts/project/_build.sh
export VIMCONFIG=~/.vim/.coding
export TMUXCONFIG=~/.tmux.conf
