source $HOME/.local/bin/env
uv venv --python 3.12 --project .
# source .venv/bin/activate
uv sync --python 3.12 --project .
# uv add -r requirements.txt --python 3.12
# ls -a 
# ls -a 
# sleep infinity
# Check if HUGGINGFACE_TOKEN is set and log in to Hugging Face
if [ -n "$HUGGINGFACE_TOKEN" ]; then
    echo "HUGGINGFACE_TOKEN is defined. Logging in..."
    # hf auth login --token $HUGGINGFACE_TOKEN --add-to-git-credential
    uvx hf auth login --token $HUGGINGFACE_TOKEN --add-to-git-credential
fi

if [ "$DEBUG" == "True" ]; then
    echo "Launch Finetune in debug mode"
fi


# python "./main.py"
# .venv/bin/torchrun --nproc_per_node=1 main.py
# source .venv/bin/activate
/PEER-runpod/.venv/bin/torchrun --nproc_per_node=1 main.py 

# hf upload BornSaint/PEER-weights final_peer_language_model.pth --private
uvx hf upload BornSaint/PEER-weights /PEER-runpod/final_peer_language_model.pth --private

if [ "$DEBUG" == "False" ]; then
    runpodctl remove pod $RUNPOD_POD_ID
fi
