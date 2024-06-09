import json
import boto3
import pymysql

# Configuration values
DB_HOST = 'your-db-host'
DB_USER = 'your-db-user'
DB_PASSWORD = 'your-db-password'
DB_NAME = 'your-db-name'

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
