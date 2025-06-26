function run_node() {
    echo "🚀 Running Node..."
    cd rl-swarm || { echo "❌ rl-swarm directory not found."; pause; return; }

    python3 -m venv .venv
    source .venv/bin/activate

    # Automatically answer the Hugging Face prompt with 'n' and press Enter for default model
    printf "n\n\n" | ./run_rl_swarm.sh

    pause
}
