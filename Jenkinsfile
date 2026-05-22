pipeline {
    agent any

    environment {
        IMAGE_NAME = 'kapilkhurana89/java-app'
        IMAGE_TAG = 'latest'
    }

    stages {

        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker build --no-cache -t %IMAGE_NAME%:%IMAGE_TAG% .'
            }
        }

        stage('Docker Push') {
            steps {

                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {

                    bat 'docker login -u %DOCKER_USER% -p %DOCKER_PASS%'
                    bat 'docker push %IMAGE_NAME%:%IMAGE_TAG%'
                }
            }
        }

        stage('Run Container') {
            steps {

                bat 'docker rm -f java-container || exit 0'

                bat 'docker run --name java-container %IMAGE_NAME%:%IMAGE_TAG%'
            }
        }
    }
}