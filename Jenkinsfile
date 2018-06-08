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
        docker.withServer('tcp://52.14.197.202:2376', '/tmp/clusterkp.pem') {
        sh """
        docker login -u jrzj64 -p rodol4fo
        docker tag hygieia:latest jrzj64/hygieia
        docker push jrzj64/hygieia
        """
            }
        }
    }
    
    stage('Deploy on swarm') {
         withDockerServer('tcp://52.14.68.130:2375') {
         sh """docker run --net jenkinspipelinelivedemo_default \
         --name demo${version} -d -p 10080 docker.artifactory:8000/demo:${version}"""
        }
    }
}


return this
