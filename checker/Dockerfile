# Python is the glue we use to run commands
# and send the results to DynamoDB after they finish
FROM python:3.8-alpine

# We also need curl and git, to test endpoints
RUN apk add --no-cache curl git

WORKDIR /code

COPY ./requirements.txt .

RUN pip install -r requirements.txt

COPY . .

ENTRYPOINT ["python", "checker.py"]
