pipeline {
    agent any
    triggers {
        pollSCM('H/5 * * * *')
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
    
        stage('Build') {
            steps {
                echo 'Build started...'
                echo "Current branch: ${env.BRANCH_NAME}"
            }
        }
    }        
}