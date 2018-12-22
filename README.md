# docker-cloudwatch
Script to send docker container stats to cloudwatch in order to use metrics, alarms, etc

This uses the aws cli to send metrics to cloudwatch - you'll need to ensure the aws command is working correctly and configured for the account you want to use.

Example crontab for running it every minute:
```* * * * * /home/ubuntu/docker-cloudwatch/send_stats.sh >> /var/log/sendstats.log 2>&1```
