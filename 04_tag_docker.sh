#NS="jacobog02"
#TAG="v1"
#NAME="jg-t1k"
source 00_vartags.sh

## pull from dockerhub to validate its online
#docker pull ${NS}/${NAME}:${TAG}

## retag with gcr stuff?
docker tag ${NS}/${NAME}:${TAG} gcr.io/jg-public-docker-gcp/${NAME}:latest

docker push gcr.io/jg-public-docker-gcp/${NAME}:latest
