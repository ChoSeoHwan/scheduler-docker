#!/bin/sh

# docker 실행시키전 대시
dockerize -wait "tcp://node-api:${NODE_API_PORT}" -timeout 30s
code=$?
if [ ${code} -eq 1 ]
    then
        echo "timeout node-api connection";
        exit 1;
fi

# nginx forground 에서 실행
nginx -g "daemon off;"