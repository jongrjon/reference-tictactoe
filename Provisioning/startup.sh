
#Starting up docker, fetching latest image versions and running docker-compose
sudo service docker start
docker pull jongrjon/tictactoe:latest
docker pull postgres
docker-compose up -d