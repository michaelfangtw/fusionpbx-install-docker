chown 33:33 config -R
docker system prune -f
docker compose down
docker compose up -d --build

