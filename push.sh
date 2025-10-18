TAG=5.4
# commit current running images 
docker commit fusionpbx michaelfangtw/fusionpbx-docker:$TAG
#tag 
docker push michaelfangtw/fusionpbx-docker:$TAG

