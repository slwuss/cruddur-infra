import json
import psycopg2
import os
import boto3


def get_db_connection():
    secret_arn = os.environ["POSTGRES_SECRET_ARN"]

    sm = boto3.client("secretsmanager")
    secret = sm.get_secret_value(SecretId=secret_arn)
    creds = json.loads(secret["SecretString"])

    return psycopg2.connect(
        host=os.environ["DB_HOST"],
        port=os.environ["DB_PORT"],
        dbname=os.environ["DB_NAME"],
        user=creds["username"],
        password=creds["password"],
        connect_timeout=5
    )


def lambda_handler(event, context):
    user = event["request"]["userAttributes"]

    user_display_name = user["name"]
    user_email        = user["email"]
    user_handle       = user["preferred_username"]
    user_cognito_id   = user["sub"]

    conn = None
    cur = None

    try:
        sql = """
          INSERT INTO public.users (
            display_name,
            email,
            handle,
            cognito_user_id
          )
          VALUES (%s, %s, %s, %s)
        """

        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute(sql, [
            user_display_name,
            user_email,
            user_handle,
            user_cognito_id
        ])

        conn.commit()

    except Exception as error:
        print("Database error:", error)
        raise

    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()
            print("Database connection closed.")

    return event