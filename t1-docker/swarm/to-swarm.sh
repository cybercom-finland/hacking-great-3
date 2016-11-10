#!/bin/sh
set -e
set -u

cd `dirname $0`
SRV_NAME=node-app-prod
IMAGE_NAME=my-node-app

usage() {
	echo "usage: $0 build|up|down"
}

awssh() {
	ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $@
}

if [ $# -ne 1 ]
then
	usage
	exit 1
fi

case "$1" in
	build)
		docker build -t "$IMAGE_NAME" ../node-app
		;;
	up)
		echo "Uploading the image to all nodes"
		local_id=`docker inspect --format="{{.Id}}" --type image "$IMAGE_NAME"`
		for ip in `terraform output master_public_ip` `terraform output worker_public_ips`
		do
			remote_id=`awssh centos@"$ip" docker inspect --format="{{.Id}}" --type image "$IMAGE_NAME" || true`
			if [ "$local_id" = "$remote_id" ]
			then
				echo "image up to date"
				continue
			fi
			docker save "$IMAGE_NAME" | gzip -| awssh centos@"$ip" 'gzip -d - | docker load'
		done
		echo "Starting the service"
		awssh centos@"`terraform output master_public_ip`" "docker service create -p 8080:8080 --replicas 2 --name $SRV_NAME $IMAGE_NAME"
		;;
	down)
		awssh centos@"`terraform output master_public_ip`" "docker service rm $SRV_NAME"
		;;
	*)
		usage
		exit 1
		;;
esac
