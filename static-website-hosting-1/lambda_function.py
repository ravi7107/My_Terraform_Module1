import json
import boto3
import pymysql

# Configuration values
DB_HOST = 'terraform-20240609052517703300000001.c9oweaww2lr2.us-east-1.rds.amazonaws.com'
DB_USER = 'admin'
DB_PASSWORD = 'password'
DB_NAME = 'mydatabase'

# Establish a connection to the RDS instance
connection = pymysql.connect(
    host=DB_HOST,
    user=DB_USER,
    password=DB_PASSWORD,
    database=DB_NAME
)

def lambda_handler(event, context):
    try:
        body = json.loads(event['body'])
        name = body['name']
        email = body['email']
        course = body['course']
        
        with connection.cursor() as cursor:
            sql = "INSERT INTO students (name, email, course) VALUES (%s, %s, %s)"
            cursor.execute(sql, (name, email, course))
        connection.commit()
        
        return {
            'statusCode': 200,
            'body': json.dumps({'success': True})
        }
    except Exception as e:
        print(e)
        return {
            'statusCode': 500,
            'body': json.dumps({'success': False, 'message': str(e)})
        }
