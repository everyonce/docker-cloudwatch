#!/bin/bash
docker stats --format "{{.Name}} {{.CPUPerc}} {{.MemUsage}} {{.MemPerc}} {{.NetIO}} {{.BlockIO}} {{.PIDs}}" --no-stream \
 | while IFS= read -r line; do { \
set -- $line; \
containername="$1"; \
line2=$(echo "$line" | sed 's/^\S*./name /g' | sed 's/[^0-9\. ]*//g'); \
echo name: $containername; \
set -- $line2; \
/home/ubuntu/.local/bin/aws cloudwatch put-metric-data --metric-name ContainerCPU --namespace DockerEngine --unit Percent --value "$1" --dimensions name=$containername; \
/home/ubuntu/.local/bin/aws cloudwatch put-metric-data --metric-name ContainerMemory --namespace DockerEngine --unit Megabytes --value "$2" --dimensions name=$containername; \
/home/ubuntu/.local/bin/aws cloudwatch put-metric-data --metric-name ContainerNetwork --namespace DockerEngine --unit Bytes/Second --value "$5" --dimensions name=$containername; \
/home/ubuntu/.local/bin/aws cloudwatch put-metric-data --metric-name ContainerDisk --namespace DockerEngine --unit Bytes/Second --value "$6" --dimensions name=$containername; \
} done
