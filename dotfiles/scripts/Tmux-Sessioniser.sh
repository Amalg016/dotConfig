selected=$(find ~/TestRepositories/JavaProjects ~/ZIDE ~/TestRepositories/CProjects ~/TestRepositories/JsProjects ~/TestRepositories/RustProjects ~/TestRepositories/ReactProjects ~/Documents/Work ~/.config -mindepth 1 -maxdepth 1 -type d | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && ! $tmux_running && tmux has-session -t $selected_name; then 
    echo "outside tmux"
    tmux attach-session -t $selected_name
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    echo "new session"
    tmux new-session -ds $selected_name -c $selected
fi
if [[ -z $TMUX ]] && ! $tmux_running; then
    echo "entering new session from outside"
    tmux attach-session -t $selected_name
    exit 0
fi
# if ! tmux has-session -t=$selected_name 2> /dev/null; then
#     echo "ddd"
#     TMUX='' tmux new -s $selected_name -c $selected
#     exit 0
# fi
echo "switch-client"
tmux switch-client -t $selected_name
