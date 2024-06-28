eval "$(fzf --bash)"
export FZF_COMPLETION_TRIGGER='..'
#bind -x '"\e[5~":"~/.config/dotfiles/scripts/Tmux-Sessioniser.sh"'
openProject(){
#find ~/TestRepositories/ -type d -not -path '*/\.git/*' -print | fzf --bind 'enter:become(nvim {})'
sh ~/.config/dotfiles/scripts/Tmux-Sessioniser.sh
}
