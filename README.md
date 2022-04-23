# instabug_backend_challenge

Application-based on ruby on rails framework

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
