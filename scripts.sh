
function publish(){
  # Get all workspaces
  workspaces=$(ls packages)

  # echo "🏗️  Building all packages..."
  # npm run build -ws

  # Check if the user is logged in to npm
  if ! npm whoami > /dev/null; then
    echo "You must be logged in to npm to publish a package."
    exit 1
  fi

  for workspace in $workspaces; do
    echo "\n⬆️  Publishing $workspace"
    cd packages/$workspace
    npm publish --dry-run; # dry run
    echo "\n✅ Published"
    cd ../../
  done
}

# Path: scripts/dev.sh
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
