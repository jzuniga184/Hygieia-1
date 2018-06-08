pipeline {
    def app

    stage("set env variables") {
         script {
             env.DOCKER = readFile 'output.txt'
         }
         echo "${env.DOCKER}"
       }

    stage('Clone repository') {
       
        checkout scm
    }
    
     stage('Build code') {
        sh "mvn clean install"
    }

    stage('Build image') {

       sh "docker-compose build"
    }


    stage('Push image') {
        sh """
        docker.withRegistry('https://registry.hub.docker.com', 'docker-id') {
        docker login --username='${$DOCKER_ID_USER}' --password='${PASSWORD}'
        docker tag hygieia:latest $DOCKER_ID_USER/hygieia
        docker push $DOCKER_ID_USER/hygieia
        """
        }
    }


return this
