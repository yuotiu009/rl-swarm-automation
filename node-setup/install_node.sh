#!/bin/bash

# ============================
# 🛠 INSTALL NODE & DEPENDENCIES
# ============================

echo "🔧 Updating system and installing dependencies..."

sudo apt update && sudo apt install -y \
  python3 python3-venv python3-pip \
  curl wget git screen lsof

# Install Node.js 20
echo "⬇️ Installing Node.js v20..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt update && sudo apt install -y nodejs

# Install Yarn
echo "📦 Installing Yarn..."
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
  sudo tee /etc/apt/sources.list.d/yarn.list > /dev/null
sudo apt update && sudo apt install -y yarn

# Show versions
echo "📜 Versions:"
node -v
npm -v
yarn -v
python3 --version

echo "✅ All tools installed successfully!"
