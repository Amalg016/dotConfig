# selected=$(git branch | fzf)
echo "aaa"
branches=$(git branch --format '%(refname:short)' | grep -v "^$(git symbolic-ref --short HEAD)$" | fzf --prompt "Select branch: " --preview "echo {}")
if[ "$branches"==""]; then
    echo "branch not selected"; return;
echo $selected
echo $branches
