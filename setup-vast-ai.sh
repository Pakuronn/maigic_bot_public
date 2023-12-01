#!/bin/bash
echo "[setup-vast-ai.sh] Started"

# disable multisession terminal
touch ~/.no_auto_tmux

SDROOT=/stable-diffusion-webui
#CONTROLNET_REPO=https://github.com/Mikubill/sd-webui-controlnet
REMOVEBG_REPO=https://github.com/Pakuronn/sd-webui-bgremove
# new controlnet:
#CONTROLNET_COMMIT=7b707dc1f03c3070f8a506ff70a2b68173d57bb5
CONTROLNET_MODEL=https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_softedge.pth
# old controlnet:
#CONTROLNET_COMMIT=c9340671d6d59e5a79fc404f78f747f969f87374 
#CONTROLNET_MODEL=https://huggingface.co/lllyasviel/ControlNet/resolve/main/models/control_sd15_hed.pth

# update start script from docker image
cd /
rm start.sh
wget -O start.sh https://raw.githubusercontent.com/Pakuronn/maigic_bot_public/master/start.sh
chmod +x start.sh

cd $SDROOT || exit 1

# Patch arguments
sed -i 's/webui.sh -f"/webui.sh -f --api --api-auth pensipens:F743kFD234! --gradio-auth pensipens:F743kFD234! --port 3000 --xformers --listen --enable-insecure-extension-access"/' ./relauncher.py

mkdir -p /lora-models
mkdir -p /hn-models

# ControlNet WebUI extension
#[[ -d dir ]] || git clone "$CONTROLNET_REPO"
#cd extensions/sd-webui-controlnet && git checkout $CONTROLNET_COMMIT
#cd $ROOT || exit 1
#mkdir -p models/ControlNet

# BgRemove extension
echo "[setup-vast-ai.sh] Installing BgRemove extension..."
cd extensions || exit 2
[[ -d "sd-webui-bgremove" ]] || git clone "$REMOVEBG_REPO"
cd $SDROOT || exit 1

# DOWNLOAD MODELS:

echo "[setup-vast-ai.sh] Downloading models..."

# deliberate v2
#cd models/Stable-diffusion || exit 3
cd /sd-models || exit 3
wget -nc -O deliberate_v2.safetensors https://civitai.com/api/download/models/15236
cd $SDROOT || exit 1

# controlnet model
# cd extensions/sd-webui-controlnet/models || exit 2
cd /cn-models || exit 2
wget -nc "$CONTROLNET_MODEL"
cd $SDROOT || exit 1


### LORA ###
cd /lora-models || exit 4

# Lora for Noir
wget -nc -O mo.safetensors https://civitai.com/api/download/models/67892

# Lora for Anime
wget -nc -O satoshiUrushihara_urushisatoV15.safetensors https://civitai.com/api/download/models/24272

# Lora for Barbie
wget -nc https://maigic.ru/static/lora-models/barbie.safetensors

# Lora for 8bit
wget -nc -O "64x64v2-10.safetensors" "https://civitai.com/api/download/models/210996?type=Model&format=SafeTensor"

# Lora for mexico
wget -nc -O CatrinaMakeUp_Concept-10.safetensors "https://civitai.com/api/download/models/62492?type=Model&format=SafeTensor"

# Lora for titans
wget -nc -O AoTStyle.safetensors "https://civitai.com/api/download/models/18647?type=Model&format=SafeTensor&size=full&fp=fp16"

# Lora for gothic
wget -nc -O ARWBedroomGothic.safetensors https://civitai.com/api/download/models/115065

# Lora for cosmos
wget -nc -O SyFyEye1_v1.0.safetensors "https://civitai.com/api/download/models/49302?type=Model&format=SafeTensor"

# Lora for pixar
wget -nc -O pixarStyleModel_lora128.safetensors "https://civitai.com/api/download/models/20450?type=Model&format=SafeTensor"

cd $SDROOT || exit 1


### Hypernetwork ###

# Hypernetwork для Anime
cd /hn-models || exit 6
#wget -nc -O incaseStyle_incaseAnythingV3.pt https://civitai.com/api/download/models/5938
wget -nc http://maigic.ru/static/hn-models/incaseStyle_incaseAnythingV3.pt

cd $SDROOT || exit 1
