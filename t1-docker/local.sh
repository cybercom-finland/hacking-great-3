#!/bin/sh
set -e
set -u

cd `dirname $0`
CONTAINER_NAME=node-app-dev
IMAGE_NAME=my-node-app

usage() {
	echo "usage: $0 build|up|down"
}

if [ $# -ne 1 ]
then
	usage
	exit 1
fi

case "$1" in
	build)
		docker build -t "$IMAGE_NAME" node-app
		;;
	up)
		docker run -d -p 8080:8080 --name "$CONTAINER_NAME" "$IMAGE_NAME"
		echo "HINT: run 'docker logs $CONTAINER_NAME' to see logs"
		;;
	down)
		docker stop "$CONTAINER_NAME"
		docker rm "$CONTAINER_NAME"
		;;
	*)
		usage
		exit 1
		;;
esac
