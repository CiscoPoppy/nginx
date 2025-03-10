pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Prepare') {
            steps {
                sh 'chmod +x deploy-nginx.sh'
            }
        }
        
        stage('Deploy Nginx') {
            steps {
                sh './deploy-nginx.sh'
            }
        }
        
        stage('Verify') {
            steps {
                sh 'curl -s http://localhost | grep "Deployed with Jenkins"'
            }
        }
    }
    
    post {
        success {
            echo 'Nginx deployment successful!'
        }
        failure {
            echo 'Nginx deployment failed!'
        }
    }
}
