node {
    def app

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
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-id') {
        def customImage = docker.build("hygieia:${env.BUILD_ID}", 
                                       "-f ${dockerfile} ./Dockerfile")
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}

return this
