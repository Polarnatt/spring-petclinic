pipeline {
    agent any
//     environment {
//         DOCKER_IMAGE_NAME = "polarnatt/cicd_project"
//         // prank
//     }
    tools {
        maven 'M3'
    }
    stages {
        stage('Build') {
            steps {
                echo 'Running build automation'
                sh './mvnw clean package'
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
                nexusUrl: '172.31.21.173:8081', 
                nexusVersion: 'nexus2', 
                protocol: 'http', 
                repository: '35.176.133.178:8081/repository/project-release/', 
                version: '2.4.5'
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
