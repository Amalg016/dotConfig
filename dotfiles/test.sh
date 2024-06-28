la=`echo "lua cpp c" | tr ' ' '\n'`
selected=`printf "$la" | fzf`
echo "selected:$selected"
