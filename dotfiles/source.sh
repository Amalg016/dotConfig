# Check if script is running in Bash
if [ -n "$BASH_VERSION" ]; then
    echo "Running in Bash, version $BASH_VERSION"
    shopt -s nullglob
    sh_files=( ~/.config/*.sh )

    for config_file in ~/.config/dotfiles/source/bash/*.bash; do
        if [ -f "$config_file" ] && [ -r "$config_file" ]; then
            source "$config_file"
        fi
    done
fi

# Check if script is running in Zsh
if [ -n "$ZSH_VERSION" ]; then
#   echo "Running in Zsh, version $ZSH_VERSION"
    for config_file in ~/.config/dotfiles/source/zsh/*.zsh; do
        if [[ -f "$config_file" && -r "$config_file" ]]; then
            source "$config_file"
        fi
    done
fi
