TAG=5.4
# commit current running images 
#docker commit fusionpbx fusionpbx-docker:$TAG
#tag 
docker tag fusionpbx-docker:$TAG michaelfangtw/fusionpbx-docker:$TAG
docker push michaelfangtw/fusionpbx-docker:$TAG

