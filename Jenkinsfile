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
        stage('Create artifact') {
            when {
                branch 'main'
            }
            steps {
                rtUpload (
                    buildName: JOB_NAME,
                    buildNumber: BUILD_NUMBER,
                    serverId: SERVER_ID, // Obtain an Artifactory server instance, defined in Jenkins --> Manage:
                    spec: '''{
                              "files": [
                                 {
                                  "pattern": "$WORKSPACE/Demo-Artifactory/Artifact_*",
                                  "target": "target/*.jar",
                                  "recursive": "false"
                                } 
                             ]
                        }''' 
                    )
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
    }    
}
