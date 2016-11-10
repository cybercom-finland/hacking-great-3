---
layout: page
title: #HackingGreat 3 @ Cybercom - Tech Track 1 - Docker track - OpenShift
---

## OpenShift

OpenShift is kubernetes with some modifications.

### OpenShift locally using minishift

#### Install minishift

Install [minishift](https://github.com/jimmidyson/minishift) following the instruction in the Internet.

Here are short instructions for Linux.

Note. That you need to have basic KVM packages and settings present, [this](https://github.com/jimmidyson/minishift/blob/master/DRIVERS.md).

- Install `docker-machine-driver-kvm`

    wget https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.7.0/docker-machine-driver-kvm
    install docker-machine-driver-kvm ~/bin/
    rm docker-machine-driver-kvm

- Install `minishift`

    wget https://github.com/jimmidyson/minishift/releases/download/v0.9.0/minishift-linux-amd64
    install minishift-linux-amd64 ~/bin/minishift
    rm minishift-linux-amd64

- Run minishift VM

    minishift start --deploy-router=true

- Install `oc` binary to use OpenShift

    HORRIBLE_PKG=openshift-origin-client-tools-v1.3.1-dad658de7465ba8a234a4fb40b5b446a45a4cee1-linux-64bit
    wget https://github.com/openshift/origin/releases/download/v1.3.1/"$HORRIBLE_PKG".tar.gz
    tar -xf "$HORRIBLE_PKG".tar.gz "$HORRIBLE_PKG"/oc -O > oc
    install oc ~/bin
    rm oc "$HORRIBLE_PKG".tar.gz

- Login to minishift

    oc login --username=admin --password=admin
    oc new-project mytest
    oc project mytest

#### Run node-app using pull method

Initalize resources

    oc create -f node-image.yaml
    oc create -f node-deployment.yaml
    oc create -f node-service.yaml
    oc create -f node-route.yaml
    oc create -f node-build.yaml

To check status use commands

    oc get all
    oc status

To access the service check URL in, but the build will take some time (see below)

    oc get route

The build will start automatically when created, but to run more issue

    oc start-build node-app-build

To see build logs, refer to build name

    oc get builds
    oc logs build/node-app-build-1

