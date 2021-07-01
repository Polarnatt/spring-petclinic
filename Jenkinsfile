pipeline {
    agent any
//     environment {
//         //be sure to replace "willbla" with your own Docker Hub username
        DOCKER_IMAGE_NAME = "polarnatt/cicd_project"
//         CANARY_REPLICAS = 0
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
                archiveArtifacts artifacts: 'target/*.jar'
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                    app.inside {
                        sh 'echo Hello, World!'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'main'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
    }    
}
