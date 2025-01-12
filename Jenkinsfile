pipeline {
    agent any

    environment {
        IMAGE_NAME = "nginx-static-site" // Docker image name
        CONTAINER_NAME = "nginx-static-site-container" // Docker container name
        REPO_URL = 'https://github.com/Sabzali2003/devopos.git' // Replace with your repo URL
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
                    docker run -d --name ${CONTAINER_NAME} -p 8090:80 ${IMAGE_NAME}
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
