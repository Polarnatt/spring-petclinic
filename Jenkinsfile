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
                version: '${BUILD_NUMBER}'
            }
        }
        stage('Deploying app to CI env'){
            steps{
                timeout(time: 40, unit: 'SECONDS'){
                    ansiblePlaybook credentialsId: 'private-key', 
                    disableHostKeyChecking: true, 
                    installation: 'ansible2', 
                    inventory: 'dev.inv', 
                    playbook: 'deploy.yml',
                    extraVars: [
                        var1: env.BUILD_NUMBER,
                    ]
                    }
            }
        }
    }
}
