#!/bin/bash
set -ex

# webui
cd ./controller-webui
npm run build
cd ../

# prepare dist files
cd ./build/controller-docker

set +ex
rm -rf ./app
rm -rf ./etc

set -ex
# controller
mkdir -p ./app/controller
rsync -a --progress ../../controller/main ./app/controller --exclude "__pycache__"
rsync -a --progress ../../controller/nexns ./app/controller --exclude "__pycache__"
rsync -a --progress ../../controller/manage.py ./app/controller
rsync -a --progress ../../controller/requirements.txt ./app/controller
rsync -a --progress ./nexns_settings.py ./app/controller/main/
# webui
rsync -a --progress ../../controller-webui/dist/ ./app/webui/
# nginx
mkdir -p ./etc/nginx/sites-enabled
cp nginx-default.conf ./etc/nginx/sites-enabled/default
# supervisord
mkdir -p ./etc/supervisor/conf.d
cp supervisord.conf ./etc/supervisor/conf.d/nexns.conf
# entrypoint
cp entrypoint.sh ./app/

# make tar file
tar cf ./dist.tar ./app ./etc

cd ../../

# build docker
docker build -t nexns-controller:v0.0.1-test .

# clean
set +ex
rm -rf ./build/controller-docker/app
rm -rf ./build/controller-docker/etc
rm ./build/controller-docker/dist.tar
rm -rf ./controller-webui/dist
