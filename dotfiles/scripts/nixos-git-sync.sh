#!/usr/bin/env zsh

set -e

cd /etc/nixos

echo "🔍 Checking Git status..."
branch=$(git rev-parse --abbrev-ref HEAD)
echo "📦 Current branch: $branch"

changes=$(git status --porcelain)
if [[ -z $changes ]]; then
  echo "✅ No changes to commit."
else
  echo "📝 Staging all changes..."
  git add -A

  timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  echo "🧾 Committing with timestamp: $timestamp"
  git commit -m "Auto-commit: $timestamp"

  echo "🚀 Pushing to GitHub..."
  git push origin "$branch"
fi

echo ""
echo "📋 Final repo status:"
git status

echo ""
echo "📈 Recent commits:"
git --no-pager log --oneline -n 5


