#!/bin/bash

ROOT=/workspace/stable-diffusion-webui
cd $ROOT || exit 1

# Patch arguments
sed -i 's/webui.sh -f"/webui.sh -f --api --api-auth pensipens:F743kFD234! --port 3000 --xformers --listen --enable-insecure-extension-access"/' ./relauncher.py

# ControlNet WebUI extension
[[ -d dir ]] || git clone https://github.com/Mikubill/sd-webui-controlnet extensions/sd-webui-controlnet
cd extensions/sd-webui-controlnet && git checkout 7b707dc1f03c3070f8a506ff70a2b68173d57bb5
cd $ROOT || exit 1
mkdir -p models/ControlNet


# MODELS

# controlnet softedge
cd extensions/sd-webui-controlnet/models || exit 2
wget -nc https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_softedge.pth
cd $ROOT || exit 1

# deliberate v2
cd models/Stable-diffusion || exit 3
wget -nc -O deliberate_v2.safetensors https://civitai.com/models/4823/deliberate
cd $ROOT || exit 1

# Lora для Noir
cd models/Lora || exit 4
wget -nc -O mo.safetensors https://disk.yandex.ru/d/HWRbQ4FFC5ayZQ
cd $ROOT || exit 1

# Lora для Anime
cd models/Lora || exit 5
wget -nc -O satoshiUrushihara_urushisatoV15.safetensors https://disk.yandex.ru/d/bTQqkaeK4UE8-g
cd $ROOT || exit 1

# Hypernetwork для Anime
cd models/hypernetworks || exit 6
wget -nc -O incaseStyle_incaseAnythingV3.pt https://disk.yandex.ru/d/HS4llKPt14dpwQ
cd $ROOT || exit 1
