#!/bin/bash
# Budget App — Deploy to Netlify
# Double-click this file in Finder, or run: bash deploy.sh

cd "$(dirname "$0")"

echo "📦 Syncing budget.html → index.html..."
cp budget.html index.html

echo "🔍 Checking for changes..."
if git diff --quiet HEAD budget.html index.html 2>/dev/null && git diff --cached --quiet HEAD budget.html index.html 2>/dev/null; then
  echo "✅ No changes to deploy."
  read -p "Press Enter to close..."
  exit 0
fi

# Use timestamp as default commit message
MSG="Update budget app — $(date '+%Y-%m-%d %H:%M')"

echo ""
echo "📝 Commit message (press Enter to use default):"
echo "   $MSG"
read -p "   Or type a custom message: " CUSTOM
if [ -n "$CUSTOM" ]; then
  MSG="$CUSTOM"
fi

echo ""
echo "🚀 Committing and pushing..."
git add budget.html index.html manifest.json sw.js icon-192.png icon-512.png CLAUDE.md 2>/dev/null
git commit -m "$MSG"
git push

echo ""
echo "✅ Done! Netlify will deploy in ~30 seconds."
echo "🌐 https://pol-budget.netlify.app"
echo ""
read -p "Press Enter to close..."
