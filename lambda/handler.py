import json
import boto3
import os
from datetime import datetime

# Initialize the DynamoDB client
dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('DYNAMODB_TABLE_NAME')

def lambda_handler(event, context):
    """
    Lambda function to handle weather data API requests.
    Processes incoming requests, performs necessary operations, 
    and returns a structured response.
    """

    # Validate that the DynamoDB table name is provided
    if not table_name:
        return generate_response(500, {"error": "DynamoDB table name not configured in environment variables."})

    try:
        # Parse the API request
        http_method = event.get('httpMethod', 'GET')
        path = event.get('path', '/')

        # Handle different API operations
        if http_method == 'GET' and path == '/weather':
            return get_weather_data(event)
        elif http_method == 'POST' and path == '/weather':
            return add_weather_data(event)
        else:
            return generate_response(404, {"error": "API route not found."})

    except Exception as e:
        # Handle unexpected errors
        return generate_response(500, {"error": f"An unexpected error occurred: {str(e)}"})


def get_weather_data(event):
    """
    Fetch weather data based on query parameters.
    """
    query_params = event.get('queryStringParameters', {})
    location = query_params.get('location', None)

    if not location:
        return generate_response(400, {"error": "Missing required query parameter: location"})

    table = dynamodb.Table(table_name)

    try:
        response = table.query(
            KeyConditionExpression=boto3.dynamodb.conditions.Key('Location').eq(location)
        )
        return generate_response(200, {"data": response.get('Items', [])})
    except Exception as e:
        return generate_response(500, {"error": f"Error fetching data: {str(e)}"})


def add_weather_data(event):
    """
    Add new weather data to the database.
    """
    try:
        body = json.loads(event.get('body', '{}'))
        location = body.get('Location')
        timestamp = body.get('Timestamp')
        weather_data = body.get('WeatherData')

        if not location or not timestamp or not weather_data:
            return generate_response(400, {"error": "Missing required fields in request body."})

        table = dynamodb.Table(table_name)
        table.put_item(
            Item={
                'Location': location,
                'Timestamp': int(timestamp),
                'WeatherData': weather_data
            }
        )

        return generate_response(201, {"message": "Weather data added successfully."})

    except Exception as e:
        return generate_response(500, {"error": f"Error adding data: {str(e)}"})


def generate_response(status_code, body):
    """
    Generate an HTTP response.
    """
    return {
        "statusCode": status_code,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(body)
    }
