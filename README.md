# instabug_backend_challenge

instabug_backend_challenge Application based on ruby on rails

Make sure you are in the backend directory

To run the following commands

# Write the following command

docker-compose up

After the docker run

Open a new terminal make sure you are in the backend directory

# Write the following commands :

docker-compose run backend bundle exec rake db:create

docker-compose run backend bundle exec rake db:migrate

if you run the previous command respectively now you can the run application curl http://localhost:3000/applications

# Incase you have an error with elasticseqrch exit 137 after run docker-compose you should maximize vm.max_map_count

# - linux
From command line

sudo sysctl -w vm.max_map_count=262144

# - Mac os

1. From the command line
run: screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty
2. Press enter and use sysctl to configure 
vm.max_map_count: sysctl -w vm.max_map_count=262144

# - Windows

From command line
wsl -d docker-desktop sysctl -w vm.max_map_count=262144


