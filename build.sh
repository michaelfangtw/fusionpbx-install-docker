TAG=5.4
docker system prune -f
docker build -t fusionpbx-docker:$TAG .

