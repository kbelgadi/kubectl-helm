def buildimage = docker.image('buildimage:latest');

pipeline {
    agent any
    environment {
        DOCKER_REPO = "897964440075.dkr.ecr.eu-west-1.amazonaws.com/ecr_demo_dev/ecr_demo_dev"
        DOCKER_IMAGE_NAME = "helm-demo"
        DOCKER_IMAGE_VERSION = "0.1"
        AWS_ACCOUNT = "897964440075"
        AWS_REGION = "eu-west-1"
        DOCKER_TAG = "${DOCKER_REPO}:${DOCKER_IMAGE_NAME}-${DOCKER_IMAGE_VERSION}"
    } 
    stages {
        stage("Prepare"){ 
               steps {
                sh '''
                  eval $(/usr/local/bin/aws ecr get-login --registry-ids ${AWS_ACCOUNT} --no-include-email --region ${AWS_REGION})
                '''
               }
        }
        stage ("Build"){
               steps { 
                sh '''
                  docker build -t "${DOCKER_TAG}" .
                '''
               }
        }
        stage ("Push"){
               steps { 
                sh '''
                  docker push "${DOCKER_TAG}"
                '''
               }
        }
    }
}