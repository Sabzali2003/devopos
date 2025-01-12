pipeline {
    agent any

    environment {
        IMAGE_NAME = "nginx-static-site" // Docker image name
        CONTAINER_NAME = "nginx-static-site-container" // Docker container name
        REPO_URL = 'https://github.com/Sabzali2003/jenkins_pipeline.git' // Replace with your repo URL
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_creds') // Jenkins credentials ID
        DOCKERHUB_REPO = "sabzali2003/nginx-static-site" // Docker Hub repository
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out source code...'
                git branch: 'main', url: "${REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    sh """
                    docker build -t ${IMAGE_NAME} .
                    docker tag ${IMAGE_NAME} ${DOCKERHUB_REPO}:latest
                    """
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                echo 'Pushing Docker image to Docker Hub...'
                script {
                    sh """
                    echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin
                    docker push ${DOCKERHUB_REPO}:latest
                    """
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'
                script {
                    sh """
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                    docker run -d --name ${CONTAINER_NAME} -p 9000:80 ${IMAGE_NAME}
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
