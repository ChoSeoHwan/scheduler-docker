FROM node:lts

RUN yarn global add pm2@^5

ARG environment

WORKDIR /usr/script
ADD $environment/script.sh ./script.sh
RUN chmod +x ./script.sh

WORKDIR /usr/src

ARG pm2_config_file
ENV PM2_CONFIG_FILE "$pm2_config_file"

ARG pm2_options
ENV PM2_OPTIONS "$pm2_options"

CMD ["/usr/script/script.sh"]
ENTRYPOINT ["sh", "-c"]