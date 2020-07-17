# Multi-container Deployment with Kubernetes on GCP

## Table of Contents

- [General info](#general-info)
- [Project Overview](#project-overview)
- [Trouble Shooting](#troubleshooting)
- [Reference](#reference)

## General Info

This repository contains a project from the course, [Docker and Kubernete: The Complete Guide](https://www.udemy.com/docker-and-kubernetes-the-complete-guide). The project aims to build a simple web application using the [Google Cloud Platform](https://cloud.google.com/) (GCP), which the first mover to support [Kubernetes](https://kubernetes.io/) (K8S).

For the CI/CD, [Travis CI](https://travis-ci.org/) and [Github](https://github.com) are used. The workflow of the CI/CD and the concept of the docker cotainers coincides with my other project, [Multi-container Deployment on AWS](https://github.com/SungjaeJung1031/multi-container-aws). Howerver, this project utilizes GCP for multi-container deployment with Kubernetes. Please refer to the page for grasp the process and the information of the docker containers.

## Project Overview

<img src="./image/architecture_detail.jpg">

Above figure shows the architecture of this project.
The architecture has a single node and is comprised of the several K8S objects, listed in the below figure.

<img src="./image/object_types.jpg">

In the [k8s](k8s) directory, you could find the all .yaml files, describing the object spec of the project target architecture.

As described in [General Info](#general-info), the concepts of the CI/CD and the docker container are the same with the my other project, [Multi-container Deployment on AWS](https://github.com/SungjaeJung1031/multi-container-aws). The main differences are as following:

1. Ingress-Nginx
2. Helm
3. Kubernetes (K8S)
4. Persistent Volume Claims (PVC)

## Troubleshooting

I have got the credential issue when GCP tries to get the credentials (line 17 in the below code block). Therefore, I have run the code without the step to finish this project. I need to figure out the cause of the issue.

```
1: sudo: required
2: services:
3:
4: - docker
5:   env:
6:   global: - SHA=\$(git rev-parse HEAD) - CLOUDSDK_CORE_DISABLE_PROMPTS=1
7:
8: before_install:
9:
10: - openssl aes-256-cbc -K $encrypted_9f3b5599b056_key -iv $encrypted_9f3b5599b056_iv -in service-account.json.enc -out service-account.json -d
11: - curl https://sdk.cloud.google.com | bash > /dev/null;
12: - source \$HOME/google-cloud-sdk/path.bash.inc
13: - gcloud components update kubectl
14: - gcloud auth activate-service-account --key-file service-account.json
15: - gcloud config set project gcp-multi-k8s
16: - gcloud config set compute/zone asia-east1-a
17: - gcloud container clusters get-credentials multi-cluster
18: - echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
19: - docker build -t jsungjei/react-test -f ./client/Dockerfile.dev ./client
20:
21: script:
22:
23: - docker run -e CI=true jsungjei/docker-react npm run test
24:
25: deploy:
26: provider: script
27: script: bash ./deploy.sh
28: on:
29: branch: master
```

[1] Stephen's Github (https://github.com/StephenGrider/DockerCasts/tree/master/diagrams)
