import argparse
import subprocess
import time

import boto3

DYNAMODB_REGION = "us-east-2"
DYNAMODB_TABLE = "History"

SERVICES = [
    "github",
    "cloudflare",
]

TESTS = {
    "github": "git clone https://github.com/github/platform-samples.git",
    "cloudflare": "curl --fail www.google.com"
}

def get_arguments():
    """
    """
    parser = argparse.ArgumentParser(description="Check service availability")
    parser.add_argument("service", choices=SERVICES, help="Service to check")
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
