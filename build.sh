TAG=1.0
docker build -t fusionpbx-install-docker:$TAG .
docker tag fusionpbx-install-docker:$TAG michaelfangtw/fusionpbx-install-docker:$TAG
docker push michaelfangtw/fusionpbx-install-docker:$TAG

