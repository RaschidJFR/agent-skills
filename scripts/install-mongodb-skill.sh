#!/bin/bash
set -e

echo "📦 Installing MongoDB Connection Skill..."

# Create temporary directory
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Download the branch as a zip file
echo "⬇️  Downloading skill from GitHub..."
curl -fsSL https://github.com/RaschidJFR/agent-skills/archive/refs/heads/install.zip \
  -o "$TEMP_DIR/repo.zip"

# Extract the zip file
echo "📦 Extracting files..."
unzip -q "$TEMP_DIR/repo.zip" -d "$TEMP_DIR"

# Create skills directory if it doesn't exist
mkdir -p ~/.claude/skills

# Remove existing installation if present (file, directory, or symlink)
if [ -e ~/.claude/skills/mongodb-connection ] || [ -L ~/.claude/skills/mongodb-connection ]; then
    echo "🗑️  Removing existing installation..."
    rm -rf ~/.claude/skills/mongodb-connection
fi

# Copy the skill (GitHub extracts install branch to agent-skills-install/)
echo "📋 Copying skill to ~/.claude/skills/mongodb-connection..."
cp -r "$TEMP_DIR/agent-skills-install/skills/mongodb-connection" ~/.claude/skills/

echo "✅ MongoDB Connection Skill installed successfully!"
echo ""
echo "The skill is now available in Claude Code."
echo "It will automatically trigger when working with MongoDB connections."
