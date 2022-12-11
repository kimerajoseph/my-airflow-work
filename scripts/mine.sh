#!/usr/bin/env bash

printf "Creating the RDS Postgres Instance...\n"
aws rds create-db-instance \
  --db-instance-identifier airflow-postgres \
  --db-instance-class db.t3.micro \
  --db-name airflow \
  --db-subnet-group-name airflow-postgres-subnet \
  --engine postgres \
  --master-username airflowadmin \
  --master-user-password supersecretpassword \
  --allocated-storage 20 \
  --no-publicly-accessible \
  --region eu-west-3