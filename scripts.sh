
function publish(){
  workspaces=$(jq -r '.workspaces[]' package.json)

  echo "🏗️  Building all packages..."
  npm run build -ws

  # Check if the user is logged in to npm
  if ! npm whoami > /dev/null; then
    echo "You must be logged in to npm to publish a package."
    exit 1
  fi

  # List packages to publish
  echo "The following packages will be published:"
  for workspace in $workspaces; do
    echo "\n⬆️  Publishing $workspace"
    cd $workspace
    # Remove the dry-run flag to actually publish the package
    npm publish --dry-run >> /dev/null;
    cd ..
    echo "\n✅ Published"
  done

  echo "\n📦 ✅ All packages published successfully"
}

# Path: scripts/dev.sh
function dev(){
  ## TODO: Automate this script
  npx concurrently --kill-others-on-fail \
    "npm run dev -w pkg-a --if-exists" \
    "npm run dev -w pkg-b --if-exists" \
    "npm run dev -w app-a --if-exists" \
    --names "pkg-a,pkg-b,app-a" \
    -c "blue,cyan,yellow" \
    --prefix "[{name}]"
}

function release(){
  npm run -ws release --if-exists;
}

# Run
$1
