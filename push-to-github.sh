#!/usr/bin/env bash

# Exit immediately if a command fails
set -e

echo "=========================================="
echo "      FoodHub GitHub Push Assistant       "
echo "=========================================="

REPO_URL="$1"

# Check if origin already exists
if git remote | grep -q "^origin$"; then
    CURRENT_REMOTE=$(git remote get-url origin)
    echo "Current remote origin: $CURRENT_REMOTE"
    if [ -n "$REPO_URL" ]; then
        git remote set-url origin "$REPO_URL"
        echo "Updated origin to: $REPO_URL"
    fi
else
    if [ -z "$REPO_URL" ]; then
        read -r -p "Enter your GitHub Repository URL (e.g. https://github.com/username/foodhub.git): " REPO_URL
    fi

    if [ -z "$REPO_URL" ]; then
        echo "Error: Repository URL is required."
        exit 1
    fi

    git remote add origin "$REPO_URL"
    echo "Added remote origin: $REPO_URL"
fi

# Ensure branch is main
git branch -M main

# Stage changes
echo "Staging all files..."
git add .

# Commit if there are changes
if git diff --staged --quiet; then
    echo "No new changes to commit."
else
    COMMIT_MSG="${2:-Update project files}"
    git commit -m "$COMMIT_MSG"
    echo "Committed changes: $COMMIT_MSG"
fi

# Push to GitHub
echo "Pushing to GitHub (main branch)..."
git push -u origin main

echo "=========================================="
echo " Successfully pushed to GitHub!           "
echo "=========================================="
