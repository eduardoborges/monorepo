

function dev(){
  workspaces=$(ls packages)

  cmd="npx concurrently --kill-others --success first"
  cmd="$cmd --prefix-colors 'bgBlue.bold,bgCyan.bold,bgGreen.bold,bgYellow.bold,bgRed.bold'";
  names=""
  for workspace in $workspaces; do
    cmd="$cmd 'npm run dev -w packages/$workspace' ";
    if([ -z "$names" ]) then
      names="$workspace";
    else
      names="$names,$workspace";
    fi
  done
  cmd="$cmd --names '$names'"
  eval $cmd
}

# Run
eval $1
