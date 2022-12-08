FROM apache/airflow:2.3.0
RUN pip3 install boto3 botocore awswrangler 
