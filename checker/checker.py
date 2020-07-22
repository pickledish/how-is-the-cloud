import argparse
import subprocess
import time

import boto3

DYNAMODB_REGION = "us-east-2"
DYNAMODB_TABLE = "History"

TESTS = {
    "github": "git clone https://github.com/airbnb/javascript.git",
    "cloudflare": "curl --fail www.google.com",
    "amazon_s3": "aws s3 ls s3://data.mytransit.nyc/subway_time/2017/ --no-sign-request",
    "pypi": "pip install requests==2.24.0",
}

def get_arguments():
    """
    """
    parser = argparse.ArgumentParser(description="Check service availability")
    parser.add_argument("service", choices=TESTS.keys(), help="Service to check")
    return parser.parse_args()

def run_test(service):
    """
    """
    return subprocess.run(TESTS.get(service), shell=True, capture_output=True)

def write_row(service, result):
    """
    """
    row = {
        "ServiceId": service,
        "CheckTime": int(time.time()),
        "ExpireTime": int(time.time()) + 86400,
        "Success": result.returncode == 0,
        "Error": result.stdout if result.returncode != 0 else "",
    }

    print(row)
    dynamodb = boto3.resource("dynamodb", region_name=DYNAMODB_REGION)
    table = dynamodb.Table(DYNAMODB_TABLE)
    table.put_item(Item=row)

def main():
    """
    """
    arguments = get_arguments()
    result = run_test(arguments.service)
    write_row(arguments.service, result)

if __name__ == "__main__":
    main()
