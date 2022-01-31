# Scheduler Docker

## Description

Scheduler 서버에 적용할 Docker 설정

## Docker 구성

### Nginx Docker

- Reverse Proxy 및 각종 network 설정을 위한 **nginx docker**


### Node API Docker

- node js process 를 실행하기 위한 **PM2 기반의 도커**


## Environment

### ETC
- `ENVIRONMENT` : 현재 실행 환경 (development/production)

### Volume mount 설정
- `NGINX_CONFIG_ROOT` : host 의 nginx config directory on host
- `NGINX_LOG_ROOT` : host 의 nginx log directory
- `NODE_API_SOURCE_ROOT` : host 의 node api source directory
- `NODE_API_LOG_ROOT` : host 의 node api log directory

### Node Api Server 설정
- `NODE_API_PORT` : Node Api connection port
- `NODE_API_PM2_CONFIG_FILE` : pm2 의 ecosystem config path
- `NODE_API_PM2_OPTIONS` : pm2 에 적용할 추가 옵션


## Usage Example

Scheduler api 서버 구성을 통한 사용 예시

### 사전 준비
- `docker` : docker container 생성을 위한  프로그램
- `docker-compose` : 다중 container 를 실행하기 위한 utility 프로그램
- `git` : 각종 소스 가져오기 위한 프로그램

### 1. Directory 생성

#### Structure
```
ec2-user    # root directory
├── data            # log directory
│   ├── nginx
│   └── scheduler-api
├── docker          # docker 실행시킬 docker-compose, dockerfile 관련 directory
├── nginx           # nginx config directory
└── scheduler-api   # scheduler-api source directory
```

#### Script

1. root directory 생성
```shell
cd /
sudo mkdir /ec2-user/
sudo chown -R ec2-user:ec2-user ./ec2-user
```

2. nginx, scheduler, docker directory 생성
```shell
mkdir /ec2-user/{nginx,scheduler-api,docker}
```

3. log data 를 저장할 directory 생성
```shell
mkdir -p /ec2-user/data/{nginx,scheduler-api}
```

### 2. nginx config setting

[Github](https://github.com/ChoSeoHwan/scheduler-nginx) 에서 nginx config clone 

```shell
cd /ec2-user/nginx/
git clone https://github.com/ChoSeoHwan/scheduler-nginx.git ./
```

### 3. Scheduler-api source clone or upload

#### Development Server

1. [Github](https://github.com/ChoSeoHwan/scheduler-api.git) 에서 scheduler-api source clone
```shell
cd /ec2-user/scheduler-api/
git clone https://github.com/ChoSeoHwan/scheduler-api.git ./
```

2. `.env` 파일 수정
```shell
cd /ec2-user/scheduler-api/
cp .env.sample .env
vi .env
```

#### Production Server

1. build docker 또는 github action 등에서 yarn install && yarn build
```shell
# build server (or github actions)
yarn install
yarn build
```

2. build 후 파일 upload
    - `./dist/` => `/ec2-user/scheduler-api/dist/`
    - `./ecosystem.config.js` => `/ec2-user/scheduler-api/ecosystem.config.js`
    - `./yarn.lock` => `/ec2-user/scheduler-api/yarn.lock`
    - `./package.json` => `/ec2-user/scheduler-api/package.json`


3. 서버에서 `.env` 파일 추가 및 수정
```shell
# our api server
cd /ec2-user/scheduler-api
vi .env
```

### 4. Docker file source clone

1. [Github](https://github.com/ChoSeoHwan/scheduler-docker.git) 에서 scheduler-docker clone

```shell
cd /ec2-user/docker
git clone https://github.com/ChoSeoHwan/scheduler-docker.git ./
```

2. .env 추가 및 수정

```shell
cp .env.sample .env
vi .env
```


### 5. Docker 실행

docker-compose 사용하여 docker container 생성

```shell
cd /ec2-user/docker
docker-compose up -d --build
```


### 6. Docker 및 각종 프로세스 확인

- docker container 실행 확인
```shell
docker ps -a
```


- docker container 실시간 로그 확인
```shell
docker logs --tail 10 -f nginx      # nginx container log 확인
docker logs --tail 10 -f node-api   # node api container log 확인
```

- node-api container 의 pm2 process 확인
```shell
docker exec node-api pm2 list   # process list 확인
docker exec node-api pm2 monit  # pm2 process monitor
```


- nginx 로그 확인
```shell
cd /ec2-user/nginx/
tail -f access.log
```
