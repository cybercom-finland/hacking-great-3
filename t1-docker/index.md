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
