#!/bin/sh

# src directory 로 이동
cd /usr/src/ || exit

# 의존성 패키지 설치 후 build
yarn install
yarn build

pm2-runtime "${PM2_CONFIG_FILE}" "${PM2_OPTIONS}" --no-auto-exit
