node {
    def app

    stage("set env variables") {
         script {
             env.PASSWORD = readFile 'output.txt'
         }
       }

    stage('Checkout') {
       
        checkout scm
    }
    
     stage('Build code') {
        sh "mvn clean install"
    }

    stage('Build docker image') {

       sh "docker-compose build"
    }


    stage('Push docker image') {
        docker.withRegistry('https://registry.hub.docker.com','docker-id') {
        sh """
        docker login -u jrzj64 -p rodol4fo
        docker tag hygieia:latest jrzj64/hygieia
        docker push jrzj64/hygieia
        """
        }
    }
    
    stage('Deploy on swarm') {
         docker.withRegistry('https://registry.hub.docker.com','docker-id') {
         sh """
         docker login -u jrzj64 -p rodol4fo
         """
             
         withDockerServer('tcp://ec2-52-14-197-202.us-east-2.compute.amazonaws.com', '/tmp/clusterkp.pem') {
         sh """
         docker service create jrzj64/hygieia
         docker push jrzj64/hygieia
         """
            
        }
    }
}


return this
