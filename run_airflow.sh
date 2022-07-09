#!/bin/bash
REQ_FILES=$1

gcloud config list account

# install pip requirements before running the airflow scheduler
if [ ! -z "$REQ_FILES" ]
  then
    pip install -r /home/user0/dags/$REQ_FILES
fi

# init db, create user, start server and scheduler
# server listens to 8080 port
airflow db init

airflow users create \
      --username user \
      --password user \
      --firstname FIRST_NAME \
      --lastname LAST_NAME \
      --role Admin \
      --email user@example.org

airflow webserver --port 8080 & airflow scheduler
