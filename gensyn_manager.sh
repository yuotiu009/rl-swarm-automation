#!/bin/bash

# GENSYN RL-SWARM SETUP & MANAGEMENT SCRIPT

clear

function install_node() {
    echo "🛠 Installing Node, Python, and dependencies..."
    sudo apt update && sudo apt install -y python3 python3-venv python3-pip curl wget screen git lsof

    python3 --version

    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt update && sudo apt install -y nodejs

    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list > /dev/null
    sudo apt update && sudo apt install -y yarn

    node -v
    npm -v
    yarn -v

    if [ ! -d "rl-swarm" ]; then
        git clone https://github.com/gensyn-ai/rl-swarm
    fi

    echo "✅ Installation complete!"
    pause
}

function run_node() {
    echo "🚀 Running Node..."
    cd rl-swarm || { echo "❌ rl-swarm directory not found."; pause; return; }

    python3 -m venv .venv
    source .venv/bin/activate

    ./run_rl_swarm.sh
    pause
}

function update_node() {
    echo "⚙️ Updating Node..."
    cd rl-swarm || { echo "❌ rl-swarm directory not found."; pause; return; }

    git switch main
    git reset --hard
    git clean -fd
    git pull origin main

    echo "✅ Node updated!"
    pause
}

function fix_errors() {
    echo "🔧 Fixing common errors..."
    sudo apt --fix-broken install -y
    sudo apt update --fix-missing
    pip install --upgrade pip
    yarn install --check-files

    echo "✅ Errors fixed!"
    pause
}

function reset_peer_id() {
    echo "♻️ Resetting Peer ID..."
    cd rl-swarm || { echo "❌ rl-swarm directory not found."; pause; return; }
    rm -f ./peer_id
    echo "✅ Peer ID reset! It will be regenerated on next run."
    pause
}

function delete_everything() {
    echo "🗑️ Deleting all files and starting fresh..."
    rm -rf rl-swarm
    echo "✅ All files deleted. Run Install again to start fresh."
    pause
}

function pause() {
    echo
    read -p "Press Enter to continue..." dummy
}

while true; do
    clear
    echo "==================== 🧠 GENSYN MAIN MENU ===================="
    echo "1. 🛠  Install/Reinstall Node"
    echo "2. 🚀 Run Node"
    echo "3. ⚙️  Update Node"
    echo "4. 🔧 Fix All Errors"
    echo "5. ♻️  Reset Peer ID"
    echo "6. 🗑️  Delete Everything & Start New"
    echo "7. ❌ Exit"
    echo "============================================================="
    echo
    read -p "Choose an option [1-7]: " choice

    case $choice in
        1) install_node ;;
        2) run_node ;;
        3) update_node ;;
        4) fix_errors ;;
        5) reset_peer_id ;;
        6) delete_everything ;;
        7) echo "❌ Exiting..."; break ;;
        *) echo "⚠️ Invalid option! Please choose between 1-7."; pause ;;
    esac
done
