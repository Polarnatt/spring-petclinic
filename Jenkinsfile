pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "polarnatt/cicd_project"
        // prank
    }
    stages {
        stage('Build') {
            steps {
                echo 'Running build automation'
                sh './mvnw package'
            }
        }
        stage('Creating and pushing artifact to Nexus') {
            steps {
                nexusArtifactUploader artifacts: [
                    [
                        artifactId: 'spring-petclinic',
                        classifier: '', 
                        file: 'target/spring-petclinic-2.4.5.jar', 
                        type: 'jar'
                    ]
                ], 
                credentialsId: 'nexus_password', 
                groupId: 'org.springframework.samples', 
                nexusUrl: '18.133.245.181:8081', 
                nexusVersion: 'nexus3', 
                protocol: 'http',
                repository: 'sample'
            }
        }
    }
}
//         stage('Push Docker Image') {
//             when {
//                 branch 'main'
//             }
//             steps {
//                 script {
//                     docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
//                         app.push("${env.BUILD_NUMBER}")
//                         app.push("latest")
//                     }
//                 }
//             }
//         }
  //  }    
//}
