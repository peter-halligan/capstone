pipeline {
    environment {
        registry = "phalligan/capstone"
        registryCredential = 'DOCKER_HUB_CREDENTIALS'
        version = '0.0.2'
    }
    agent any
    stages {
        stage('Setup') {
            steps {
                sh "make setup"
            }
        }

        stage('install') {
            steps {
                sh 'make install'
            }
        }

        stage('Lint') {
            steps {
                sh 'make lint'
            }
        }
        stage('Test') {
            steps {
                sh 'make test'
            }
        }

        stage('Building image') {
            steps{
            script {
                dockerImage = docker.build registry + ":" + version
                }
            }
        }

        stage('Upload Image') {
            steps{
            script {
                docker.withRegistry( registry, registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
        }

        // stage('Deploy Updated Image to Cluster'){
        //     steps {
        //         catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
        //         sh 'kubectl apply -f ./kubernetes/deploy-hello-green.yml'
        // 		sh 'kubectl apply -f ./kubernetes/service-hello-green.yml'
        //     }
        // }
    }
}