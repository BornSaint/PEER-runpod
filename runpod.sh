# !/bin/bash

start=$(date +%s)

# Detect the number of NVIDIA GPUs and create a device string
gpu_count=$(nvidia-smi -L | wc -l)
if [ $gpu_count -eq 0 ]; then
    echo "No NVIDIA GPUs detected. Exiting."
    exit 1
fi
# Construct the CUDA device string
cuda_devices=""
for ((i=0; i<gpu_count; i++)); do
    if [ $i -gt 0 ]; then
        cuda_devices+=","
    fi
    cuda_devices+="$i"
done

# clear
# pwd
# ls -a
# sleep infinity
cd PEER-runpod
# Install dependencies
apt update
apt install -y python3.12 python3.12-dev python3.12-venv python3.12-pip
cd /PEER-runpod
source ./.venv/bin/activate
python3.12 -m pip install -U pip
python3.12 -m pip install -U setuptools wheel
python3.12 -m pip install -r requirements.txt

apt install -y screen vim git-lfs
screen

sleep infinity



# source $HOME/.local/bin/env
# uv venv --python 3.12 --project .
# # source .venv/bin/activate
# uv sync --python 3.12 --project .
# # uv add -r requirements.txt --python 3.12
# # ls -a 
# # ls -a 
# # sleep infinity
# # Check if HUGGINGFACE_TOKEN is set and log in to Hugging Face
# if [ -n "$HUGGINGFACE_TOKEN" ]; then
#     echo "HUGGINGFACE_TOKEN is defined. Logging in..."
#     # hf auth login --token $HUGGINGFACE_TOKEN --add-to-git-credential
#     uvx hf auth login --token $HUGGINGFACE_TOKEN --add-to-git-credential
# fi

# if [ "$DEBUG" == "True" ]; then
#     echo "Launch Finetune in debug mode"
# fi


# # python "./main.py"
# # .venv/bin/torchrun --nproc_per_node=1 main.py
# # source .venv/bin/activate
# /PEER-runpod/.venv/bin/torchrun --nproc_per_node=1 main.py 

# # hf upload BornSaint/PEER-weights final_peer_language_model.pth --private
# uvx hf upload BornSaint/PEER-weights /PEER-runpod/final_peer_language_model.pth --private

# if [ "$DEBUG" == "False" ]; then
#     runpodctl remove pod $RUNPOD_POD_ID
# fi

# # sleep infinity
