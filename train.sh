

cd /PEER-runpod
source ./venv/bin/activate
python3.12 -m pip install -U pip
python3.12 -m pip install -U setuptools wheel
python3.12 -m pip install -r requirements.txt

# Check if HUGGINGFACE_TOKEN is set and log in to Hugging Face
if [ -n "$HUGGINGFACE_TOKEN" ]; then
    echo "HUGGINGFACE_TOKEN is defined. Logging in..."
    # hf auth login --token $HUGGINGFACE_TOKEN --add-to-git-credential
    hf auth login --token $HUGGINGFACE_TOKEN --add-to-git-credential
fi

if [ "$DEBUG" == "True" ]; then
    echo "Launch Finetune in debug mode"
fi

torchrun --nproc_per_node=1 main.py
# hf upload BornSaint/PEER-weights final_peer_language_model.pth --private
hf upload BornSaint/PEER-weights /PEER-runpod/final_peer_language_model.pth --private

if [ "$DEBUG" == "False" ]; then
    runpodctl remove pod $RUNPOD_POD_ID
fi
