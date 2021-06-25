#!/bin/bash
echo "org: " $1
echo "token: " $2

while true;
do
				docker build --tag runner-image:test --file ./Dockerfile .
				docker run \
								--env ORGANIZATION=$1 \
								--env ACCESS_TOKEN=$2 \
								--name runner \
								runner-image:test
				docker container rm runner --force
done
