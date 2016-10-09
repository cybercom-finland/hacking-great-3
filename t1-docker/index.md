---
layout: page
title: #HackingGreat 3 @ Cybercom - Tech Track 1 - Docker track
---

## Tech Track 1 - Some Docker pipeline stuff

We have a trivial node.js web application in `node-app` directory.

### Running code in Local Docker

To run the application in local docker container use

    sh local.sh build
    sh local.sh up

and browse to <http://localhost:8080>

If you do a change you need to tear the container up and down.

    sh local.sh build
    sh local.sh down
    sh local.sh up


### OpenShift

OpenShift is kubernetes with some modifications.

#### OpenShift locally using minishift

##### Install minishift

Install [minishift](https://github.com/jimmidyson/minishift) following the instruction in the Internet.

Here are short instructions for Linux.

Note. That you need to have basic KVM packages and settings present, [this](https://github.com/jimmidyson/minishift/blob/master/DRIVERS.md).

- Install `docker-machine-driver-kvm`

    wget https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.7.0/docker-machine-driver-kvm
    install docker-machine-driver-kvm ~/bin/
    rm docker-machine-driver-kvm

- Install `minishift`

    wget https://github.com/jimmidyson/minishift/releases/download/v0.7.1/minishift-linux-amd64
    install minishift-linux-amd64 ~/bin/minishift
    rm minishift-linux-amd64

- Run minishift VM

    minishift start --deploy-router=true

- Install `oc` binary to use OpenShift

    HORRIBLE_PKG=openshift-origin-client-tools-v1.3.0-3ab7af3d097b57f933eccef684a714f2368804e7-linux-64bit
    wget https://github.com/openshift/origin/releases/download/v1.3.0/"$HORRIBLE_PKG".tar.gz
    tar -xf "$HORRIBLE_PKG".tar.gz "$HORRIBLE_PKG"/oc -O > oc
    install oc ~/bin
    rm oc "$HORRIBLE_PKG".tar.gz

- Login to minishift

    oc login --username=admin --password=admin
    oc new-project mytest
    oc project mytest

##### Run node-app using pull method

Initalize resources

    oc create -f openshift/node-image.yaml
    oc create -f openshift/node-deployment.yaml
    oc create -f openshift/node-service.yaml
    oc create -f openshift/node-route.yaml
    oc create -f openshift/node-build.yaml

The build will start automatically, but to run more issue

    oc start-build node-app-build

To see build logs, refer to build name

    oc get builds
    oc logs build/node-app-build-1

