#NS="jacobog02"
#TAG="v1"
#NAME="jg-pathogen"
source 00_vartags.sh

## Manually build docker image and see where it is failing 
docker build -t ${NS}/${NAME}:${TAG} -f Dockerfile --progress=plain .
