# Checker

A simple Python script that helps verify whether cloud services are actually running by attempting to hit them with real commands that people would normally use.

Main function is to include a mapping from `service` to `command`, with `service` being the cloud service name and `command` being the shell command used to verify whether the service is really working. We wrap it all up in a Docker image, so (a) we can make sure all binaries we need (`curl`, `aws`, `git`, etc) are installed, and (b) we can run the image in Fargate containers on ECS (or anywhere else).
