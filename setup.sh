#!/bin/bash

# 🔽 SETUP: Clone only the inner files (no outer folder) into ~/gensyn
echo "📦 Cloning GENSYN automation files..."
mkdir -p ~/gensyn && cd ~/gensyn

# Init repo and sparse checkout
git init
git remote add origin https://github.com/yuotiu009/rl-swarm-automation.git
git config core.sparseCheckout true
echo "/*" > .git/info/sparse-checkout

# Pull only contents (not the top folder)
git pull origin main

# ✅ Make all .sh scripts executable
echo "🔐 Setting executable permissions..."
find . -type f -name "*.sh" -exec chmod +x {} \;

# 📂 Show folder contents
echo "✅ Files ready in ~/gensyn:"
ls -alh

# ▶️ Optional: Run the main menu script
echo "🚀 Running the main menu (gensyn_manager.sh)..."
./gensyn_manager.sh
