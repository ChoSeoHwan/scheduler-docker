FROM nginx:latest

# dockerize 다운
RUN apt-get update && apt-get install -y wget
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# shell script 추가
WORKDIR /usr/script
ADD ./script.sh ./
RUN chmod +x ./script.sh

WORKDIR /etc/nginx/conf.d

ARG node_api_port
ENV NODE_API_PORT "$node_api_port"

CMD ["/usr/script/script.sh"]