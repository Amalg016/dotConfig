autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{202}[%f%F{152}%n%f %F{211}%1~%f%F{202}]%f %F{112}${vcs_info_msg_0_}%f$ '
# %F starts the block

export LC_ALL=en_US.UTF-8
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

