#!/bin/bash
rm /setup-vast-ai.sh
wget -O /setup-vast-ai.sh https://raw.githubusercontent.com/Pakuronn/maigic_bot_public/master/setup-vast-ai.sh
chmod +x /setup-vast-ai.sh
/setup-vast.ai.sh
/start.sh