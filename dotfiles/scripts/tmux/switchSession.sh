# Check if tmux is installed

# Get the list of tmux sessions

# Exit if no sessions are found
# if [ -z "$sessions" ]; then
#   echo "No tmux sessions found."
#   exit 1
# fi

# Use fzf to select a session
selected_session=$(tmux list-sessions -F "#S" | fzf --prompt="Select a tmux session: ")
# Exit if no session is selected

if [[ -z $selected_session ]]; then
    exit 0
fi
echo "Switching to $selected_session"
# Switch to the selected session
tmux switch-client -t $selected_session || tmux attach-session -t $selected_session
