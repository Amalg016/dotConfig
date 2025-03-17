if [ $# -gt 0 ]; then
    options=("$HOME/eclipse-workspace/work_zohodesk1/" "$HOME/Documents/Work"  "$HOME/Work/client_projects/zohodesk_react_poc/" "$HOME/Work/client_projects/react_client")
    selected=$(printf '%s\n' "${options[@]}" | fzf)
else
    selected=$(find ~/PersonalProjects/JavaProjects ~/PersonalProjects/CProjects ~/PersonalProjects/JsProjects ~/PersonalProjects/RustProjects ~/PersonalProjects/ReactProjects ~/Documents/Work  ~/PersonalProjects/GoProjects ~/PersonalProjects/ZigProjects ~/.config -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename $selected | tr . _)
echo $selected_name
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && ! $tmux_running && tmux has-session -t $selected_name; then 
    echo "outside tmux"
    tmux attach-session -t $selected_name
    exit 0
fi
tmux ls
if ! tmux has-session -t=$selected_name 2> /dev/null; then
    echo "new session"
    echo $selected
    echo $selected_name
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
