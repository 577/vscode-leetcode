#!/usr/bin/env bash
set -e

echo "Installing dependencies..."
npm install

echo "Compiling TypeScript..."
./node_modules/.bin/tsc -p ./

echo "Packaging VSIX..."
npx @vscode/vsce package

VSIX_FILE=$(ls -1 *.vsix | tail -n1)
echo "Build complete: $VSIX_FILE"

echo "Uninstalling existing extension..."
codium --uninstall-extension LeetCode.vscode-leetcode 2>/dev/null || true

echo "Installing $VSIX_FILE..."
codium --install-extension "$VSIX_FILE"

echo ""
echo "Done. Please reload Codium to apply changes."
