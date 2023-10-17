#!/bin/bash
VSCODE_CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS_NAME=$(uname -s)

if [[ "$OS_NAME" == "Linux" ]]; then
  cd "$VSCODE_CWD/vscode-linux"
  ./code --user-data-dir="$VSCODE_CWD/data" "$@"
elif [[ "$OS_NAME" == "MINGW"* || "$OS_NAME" == "MSYS"* || "$OS_NAME" == "CYGWIN"* ]]; then
  cd "$VSCODE_CWD/vscode-win"
  ./Code.exe --user-data-dir="$VSCODE_CWD/data" "$@"
else
  echo "El sistema operativo $OS_NAME no es compatible."
  exit 1
fi
]]]