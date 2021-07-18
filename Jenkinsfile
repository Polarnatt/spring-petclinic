// pipeline {
//     agent any
//     tools {
//         maven 'M3'
//     }
//     stages {
//         stage('Build') {
//             steps {
//                 echo 'Running build automation'
//                 sh './mvnw clean package'
//             }
//         }
//         stage('Push artifact to Nexus') {
//             steps {
//                 nexusArtifactUploader artifacts: [
//                     [

//                         artifactId: 'spring-petclinic', 
//                         classifier: '', 
//                         file: 'target/spring-petclinic-2.4.5.jar', 
//                         type: 'jar'
//                     ]
//                 ], 
//                 credentialsId: 'nexus_password', 
//                 groupId: 'org.springframework.samples', 
//                 nexusUrl: '172.31.19.118:8081', 
//                 nexusVersion: 'nexus3', 
//                 protocol: 'http', 
//                 repository: 'project-release', 
//                 version: '${BUILD_NUMBER}'
//             }
//         }
//         stage('Choose artifact version'){
//             steps{
//                 script{
//                     env.NUMBER = input message: 'Please enter the number of artifact version, that you want to build',
//                                  parameters: [string(defaultValue: '',
//                                               description: '',
//                                               name: 'Number')]
//                 }
//             }
//         }
//         stage('Deploying app to CI env'){
//             steps{
//                     ansiblePlaybook credentialsId: 'private-key', 
//                     disableHostKeyChecking: true, 
//                     installation: 'ansible2', 
//                     inventory: 'dev.inv', 
//                     playbook: 'deploy.yml',
//                     extraVars: [
//                         var1: env.NUMBER,
//                     ]
//             }
//         }
//     }
// }

pipeline {
    agent any
    
    environment {
        imageName = "spring-petclinic:$BUILD_NUMBER"
        registryCredentials = "nexus_creds"
        registry = "oleksandrsvystun3c.mylabserver.com:8083"
        dockerImage = ""
    }
    
    stages {
        stage('Building image'){
            steps{
                script{
                    dockerImage = docker.build imageName
                }
            }
        }
        stage('Uploading to Nexus'){
            steps{
                script{
                    docker.withRegistry('http://'+registry, registryCredentials){
                        dockerImage.push('$BUILD_NUMBER')  
                    }
                }
            }
        }
        stage('Choose artifact version'){
            steps{
                script{
                    env.NUMBER = input message: 'Please enter the number of artifact version, that you want to build',
                                 parameters: [string(defaultValue: '',
                                              description: '',
                                              name: 'Number')]
                }
            }
        }
        stage('Deploying app to CI env'){
            steps{
                    ansiblePlaybook credentialsId: 'private-key', 
                    disableHostKeyChecking: true, 
                    installation: 'ansible2', 
                    inventory: 'dev.inv', 
                    playbook: 'deploy.yml',
                    extraVars: [
                        var1: env.NUMBER,
                    ]
               
            }
        }
    }
}
