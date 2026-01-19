
apt install python3.12 python3.12-dev python3.12-venv
cd /PEER-runpod
source ./.venv/bin/activate

# Check if HUGGINGFACE_TOKEN is set and log in to Hugging Face
if [ -n "$HUGGINGFACE_TOKEN" ]; then
    echo "HUGGINGFACE_TOKEN is defined. Logging in..."
    # hf auth login --token $HUGGINGFACE_TOKEN --add-to-git-credential
    hf auth login --token $HUGGINGFACE_TOKEN --add-to-git-credential
fi

if [ "$DEBUG" == "True" ]; then
    echo "Launch Finetune in debug mode"
fi

python3.12 -m torchrun --nproc_per_node=1 main.py
# hf upload BornSaint/PEER-weights final_peer_language_model.pth --private
hf upload BornSaint/PEER-weights /PEER-runpod/final_peer_language_model.pth --private

if [ "$DEBUG" == "False" ]; then
    runpodctl remove pod $RUNPOD_POD_ID
fi
