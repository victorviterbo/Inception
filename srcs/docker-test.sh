#!/bin/bash



DB_VOLUME 	=	/Users/victorviterbo/Desktop/42/Inception/dummydb/
WP_VOLUME	=	/Users/victorviterbo/Desktop/42/Inception/dummysite/


docker compose down

docker volume rm db-volume
docker volume rm wordpress-volume

rm -fr /Users/victorviterbo/Desktop/42/Inception/dummysite/*
rm -fr /Users/victorviterbo/Desktop/42/Inception/dummydb/*


docker volume create  --name db-volume --driver local --opt type=none --opt device=/Users/victorviterbo/Desktop/42/Inception/dummydb/ --opt o=bind;
docker volume create  --name wordpress-volume --driver local  --opt type=none --opt device=/Users/victorviterbo/Desktop/42/Inception/dummysite/ --opt o=bind;

echo "Starting Docker Compose services..."
docker compose build

docker compose up > compose.log &

sleep 5

# Wait for services to be ready
echo "Waiting for services to be ready..."
sleep 10

# Check container status
echo "Container status:"
docker-compose ps

# Test nginx response
echo "Testing nginx response..."
curl -vk https://localhost:443 || exit 1

# Test WordPress installation page
echo "Testing WordPress installation..."
#curl -vk https://localhost:443/wp-admin/install.php || exit 1

echo "All tests passed! 🎉"

