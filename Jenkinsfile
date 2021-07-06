pipeline {
    agent any
    tools {
        maven 'M3'
    }
    // test
    stages {
        stage('Build') {
            steps {
                echo 'Running build automation'
                sh './mvnw clean package'
            }
        }
        stage('Push artifact to Nexus') {
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
                nexusUrl: '172.31.19.118:8081', 
                nexusVersion: 'nexus3', 
                protocol: 'http', 
                repository: 'project-release', 
                version: '${BUILD_NUMBER}-2.4.5'
            }
        }
        stage('Deploying app to CI env'){
            steps{
                ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansible2', inventory: 'dev.inv', playbook: 'deploy.yml'
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
