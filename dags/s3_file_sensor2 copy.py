from airflow.models import DAG
from datetime import datetime, timedelta
from airflow.operators.python_operator import PythonOperator
from airflow.providers.amazon.aws.sensors.s3 import S3KeySensor
import boto3
from airflow.models import Variable

BUCKET_NAME = Variable.get("redshift_bucket")
#FILE_NAME= "green_tripdata_2021-01.parquet"
FILE_NAME="new_req_10.txt"
aws_access_key_id=Variable.get("aws_access_key_id")
aws_secret_access_key=Variable.get("aws_access_key_value")

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2022, 2, 22),
    'email': ['nic@enye.tech'],
    'email_on_failure': False,
    'max_active_runs': 1,
    'email_on_retry': False,
    'retry_delay': timedelta(minutes=5)
}

#s3 = boto3.client('s3')

def processing_func(**kwargs):
    client = boto3.client(
    's3',
    aws_access_key_id=aws_access_key_id,
    aws_secret_access_key=aws_secret_access_key,
    region_name="eu-west-3"
    #aws_session_token=SESSION_TOKEN
    )
    print("Reading the file")        
    obj = client.get_object(Bucket=BUCKET_NAME, Key=FILE_NAME)
    lin = obj['Body'].read().decode("utf-8")
    print(lin)
    return lin

with DAG(
    dag_id="second_test_s3_file_sensor",
    schedule_interval="@daily",
    default_args=default_args,
    catchup=False,
    max_active_runs=1,
    tags=['testing-dags'],
    ) as dag:

    # The DAG will check whether the file has arrived or not after every 1 minute and
    #  it will timeout after 180 seconds. If the file is found, it will run the 
    #  specified Python function. 
    s3_sensor = S3KeySensor(
        task_id='s3_file_check',
        poke_interval=60,
        timeout=180,
        soft_fail=False,
        retries=2,
        bucket_key=FILE_NAME,
        bucket_name=BUCKET_NAME,
        aws_conn_id='s3_conn',
        #dag=dg
        )


    func_task = PythonOperator(
        task_id='a_task_using_found_file',
        python_callable=processing_func,
        op_kwargs={
            'FILE_NAME': FILE_NAME,
            "BUCKET_NAME":BUCKET_NAME
        }
        #dag=dg
        )

    #s3_sensor >> func_task
    #s3_sensor &gt;&gt; func_task
    #t2.set_upstream(t1)

    func_task.set_upstream(s3_sensor)