# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

autoload -Uz compinit
compinit

# Ignore completion for specific commands
zstyle ':completion:*:*:git:*' ignored-patterns '*/.git/*'

# Set completion styles
zstyle ':completion:*:*:kill:*' menu yes select

