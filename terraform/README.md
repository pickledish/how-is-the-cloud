# Terraform

Contains the Terraform code of all infrastructure needed for this project.

### Details

| Module       | Purpose                                                                                 |
| ------       | -------                                                                                 |
| `cloudwatch` | Handles the infra that schedules the tasks to run every X minutes                       |
| `dynamodb`   | Contains the definition of the actual DynamoDB table that holds check history           |
| `ecs`        | Contains the definitions of the actual service check containers, including IAM policies |
| `site`       | Handles the IAM access keys for the website to use to read the history table            |
