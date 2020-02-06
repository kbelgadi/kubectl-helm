def buildimage = docker.image('buildimage:latest');

pipeline {
    agent any
    environment {
        DOCKER_REPO = "897964440075.dkr.ecr.eu-west-1.amazonaws.com/ecr_demo_dev"
        DOCKER_IMAGE_NAME = "helm-demo1"
        DOCKER_IMAGE_VERSION = "0.1"
        AWS_ACCOUNT = "897964440075"
        AWS_REGION = "eu-west-1"
    } 
    stages {
        stage("Prepare"){ 
               steps {
                sh '''
                  echo hello
                  eval $(/usr/local/bin/aws ecr get-login --registry-ids ${AWS_ACCOUNT} --no-include-email --region ${AWS_REGION})
                '''
               }
        }
        stage ("Build"){
               steps { 
                sh '''
                  echo hello
                  ls
                  docker build -t "${env.DOCKER_REPO}:${env.DOCKER_IMAGE_NAME}${env.DOCKER_IMAGE_VERSION}" .
                '''
               }
        }
        stage ("Push"){
               steps { 
                sh '''
                  docker push "${env.DOCKER_REPO}:${env.DOCKER_IMAGE_NAME}${env.DOCKER_IMAGE_VERSION}"
                '''
               }
        }
    }
}