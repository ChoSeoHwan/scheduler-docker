#!/bin/sh

# src directory 로 이동
cd /usr/src/ || exit

# production 모드로 패키지 install
yarn install --production

# production 모드로 pm2 실행
pm2-runtime "${PM2_CONFIG_FILE}" --env=production "${PM2_OPTIONS}" --no-auto-exit
