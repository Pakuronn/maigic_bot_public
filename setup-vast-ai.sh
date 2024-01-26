#!/bin/bash
echo "[setup-vast-ai.sh] Started"

# disable multisession terminal
touch ~/.no_auto_tmux

SDROOT=/stable-diffusion-webui
#CONTROLNET_REPO=https://github.com/Mikubill/sd-webui-controlnet
REMOVEBG_REPO=https://github.com/Pakuronn/sd-webui-bgremove
REACTOR_REPO=https://github.com/Gourieff/sd-webui-reactor
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
sed -i 's/webui.sh -f"/webui.sh -f --disable-safe-unpickle --api --api-auth pensipens:F743kFD234! --gradio-auth pensipens:F743kFD234! --port 3000 --xformers --listen --enable-insecure-extension-access"/' ./relauncher.py

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

# Reactor extension
echo "[setup-vast-ai.sh] Installing Reactor extension..."
cd extensions || exit 2
[[ -d "sd-webui-reactor" ]] || git clone "$REACTOR_REPO"
cd "sd-webui-reactor" && git checkout ed66d91 # fix for error: https://github.com/Gourieff/sd-webui-reactor/issues/282
cd $SDROOT || exit 1

# transparent-background
cd /root || exit 11
mkdir -p .transparent-background
cd .transparent-background || exit 11
wget -nc https://maigic.ru/static/sd-root/latest.pth
cd /

# DOWNLOAD MODELS:

echo "[setup-vast-ai.sh] Downloading models..."

# deliberate v2
#cd models/Stable-diffusion || exit 3
cd /sd-models || exit 3
#wget -nc -O deliberate_v2.safetensors https://civitai.com/api/download/models/15236
wget -nc https://maigic.ru/static/sd-models/deliberate_v2.safetensors
cd $SDROOT || exit 1

# controlnet model
# cd extensions/sd-webui-controlnet/models || exit 2
cd /cn-models || exit 2
wget -nc "$CONTROLNET_MODEL"
cd $SDROOT || exit 1

### если opencv > 4.7 (при запуске webui выдается ошибка про Layer), то заменить модель:
# cd /workspace/stable-diffusion-webui/models/opencv || exit 3
# mv ./face_detection_yunet.onnx ./face_detection_yunet--old.onnx
# wget -O face_detection_yunet.onnx https://github.com/opencv/opencv_zoo/raw/main/models/face_detection_yunet/face_detection_yunet_2023mar.onnx?download=

### LORA ###
cd /lora-models || exit 4

# Lora for Noir
wget -nc "https://maigic.ru/static/lora-models/mo.safetensors"

# Lora for Anime
wget -nc "https://maigic.ru/static/lora-models/satoshiUrushihara_urushisatoV15.safetensors"

# Lora for Barbie
wget -nc "https://maigic.ru/static/lora-models/barbie.safetensors"

# Lora for 8bit
wget -nc "https://maigic.ru/static/lora-models/64x64v2-10.safetensors"

# Lora for mexico
wget -nc "https://maigic.ru/static/lora-models/CatrinaMakeUp_Concept-10.safetensors"

# Lora for titans
wget -nc "https://maigic.ru/static/lora-models/AoTStyle.safetensors"

# Lora for gothic
wget -nc "https://maigic.ru/static/lora-models/ARWBedroomGothic.safetensors"

# Lora for cosmos
wget -nc "https://maigic.ru/static/lora-models/SyFyEye1_v1.011111.safetensors"

# Lora for pixar
wget -nc "https://maigic.ru/static/lora-models/pixarStyleModel_lora128.safetensors"

# Lora for simpsons
wget -nc "https://maigic.ru/static/lora-models/The_Simpson_Style.safetensors"

# Lora for newyear
wget -nc "https://maigic.ru/static/lora-models/christmas-photo-v1.2.safetensors"

# Lora for gta
wget -nc "https://maigic.ru/static/lora-models/GTA_Style.safetensors"

cd $SDROOT || exit 1


### Hypernetwork ###

# Hypernetwork для Anime
cd /hn-models || exit 6
#wget -nc -O incaseStyle_incaseAnythingV3.pt https://civitai.com/api/download/models/5938
wget -nc http://maigic.ru/static/hn-models/incaseStyle_incaseAnythingV3.pt

cd $SDROOT || exit 1
