
source 00_vartags.sh
## Run the image interacively, see if all tools run and the example workflows work manually 
#docker pull jacobog02/jg-t1k:v1
docker run -it -v `pwd`:`pwd` -w `pwd` ${NS}/${NAME}:${TAG}
