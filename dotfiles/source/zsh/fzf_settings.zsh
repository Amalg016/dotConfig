source <(fzf --zsh)
export FZF_COMPLETION_TRIGGER='..'

openProject(){
#find ~/TestRepositories/ -type d -not -path '*/\.git/*' -print | fzf --bind 'enter:become(nvim {})'
sh ~/.config/dotfiles/scripts/Tmux-Sessioniser.sh
}

# selected=$(git branch | fzf)
giiiiiiiiiiiiii(){
    echo "aaa"
    branches=`git branch --format '%(refname:short)' | grep -v "^$(git symbolic-ref --short HEAD)$" | fzf --prompt "Select branch: "`

# If no branch was selected, return
    if [ "$branches" = "" ]; then
        echo "No branch selected."
        return 1
    fi
    echo $selected
    echo $branches
}


gb(){
local pattern=$*
local branches branch
branches=$(git branch | awk 'tolower($0) ~ /'"$pattern"'/') &&
branch=$(echo "$branches" | fzf-tmux -p --reverse -1 -0 +m) &&

if [ -z "$branch" ]; then
        echo "[$0] No branch matches the provided pattern."
        return
fi
    git switch "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##" | sed "s/ //")"
}


# Function to add files to the git staging area
function git_add_with_fzf() {
  local selected_files
  selected_files=$(git status --porcelain | awk '{print $2}' | fzf --multi --preview 'git diff --color=always {}')

  if [[ -n "$selected_files" ]]; then
    echo "$selected_files" | xargs git add
    echo "Added files to staging area:"
    echo "$selected_files"
  else
    echo "No files selected."
  fi
}


# Function to remove files from the git staging area
function git_reset_with_fzf() {
  local selected_files
  selected_files=$(git diff --cached --name-only | fzf --multi --preview 'git diff --cached --color=always {}')

  if [[ -n "$selected_files" ]]; then
    echo "$selected_files" | xargs git reset
    echo "Removed files from staging area:"
    echo "$selected_files"
  else
    echo "No files selected."
  fi
}

