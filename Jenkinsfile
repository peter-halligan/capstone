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
                docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy to green'){
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    withAWS(region:'us-west-2', credentials:'AWS_CREDENTIALS') {
                        sh '''    
                            /usr/local/bin/kubectl apply -f ./kubernetes/deploy-hello-green.yml

                            ATTEMPTS=0
                            ROLLOUT_STATUS_CMD="/usr/local/bin/kubectl rollout status deployment/myapp"
                            until $ROLLOUT_STATUS_CMD || [ $ATTEMPTS -eq 60 ]; do
                                $ROLLOUT_STATUS_CMD
                                ATTEMPTS=$((attempts + 1))
                                sleep 10
                            done

                            /usr/local/bin/kubectl apply -f ./kubernetes/service-hello-green.yml
                        '''
                    }
                }
            }
        }
    }
}