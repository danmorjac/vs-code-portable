#!/bin/bash
DIR=$(dirname "$0")
DATA="$DIR/vscode-win/data"
CODE=$(which code 2>/dev/null || echo "$DIR"/vscode-linux/code)
"$CODE" --user-data-dir="$DATA" --extensions-dir "$DATA/extensions" "$@"
