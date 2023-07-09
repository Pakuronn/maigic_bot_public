#!/bin/bash
echo "[setup-vast-ai.sh] Started"

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
sed -i 's/webui.sh -f"/webui.sh -f --api --api-auth pensipens:F743kFD234! --port 3000 --xformers --listen --enable-insecure-extension-access"/' ./relauncher.py

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

# Lora для Noir
cd /lora-models || exit 4
wget -nc -O mo.safetensors https://civitai.com/api/download/models/67892
cd $SDROOT || exit 1

# Lora для Anime
cd /lora-models || exit 5
wget -nc -O satoshiUrushihara_urushisatoV15.safetensors https://civitai.com/api/download/models/24272
cd $SDROOT || exit 1

# Lora для Barbie
cd /lora-models || exit 5
wget -nc -O https://maigic.ru/static/lora-models/barbie.safetensors
cd $SDROOT || exit 1

# Hypernetwork для Anime
cd /hn-models || exit 6
wget -nc -O incaseStyle_incaseAnythingV3.pt https://civitai.com/api/download/models/5938
cd $SDROOT || exit 1
