FROM node:lts

RUN yarn global add pm2@^5

WORKDIR /usr/src/app

CMD ["ecosystem.config.js"]
ENTRYPOINT ["pm2-runtime"]