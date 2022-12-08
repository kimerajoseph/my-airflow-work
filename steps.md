LINKS

## installing and running airflow locally in docker containers
https://towardsdatascience.com/run-airflow-docker-1b83a57616fb

## downloading data from s3 bucket
https://betterdatascience.com/apache-airflow-amazon-s3-download/

## uploading files to s3 buckets
https://betterdatascience.com/apache-airflow-amazon-s3/

docker-compose down
docker-compose up airflow-init
docker-compose up

## stop containers and delete all images 
docker kill $(docker ps -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)



