pipeline {
    agent any
    stages {
        stage('Clone only') {
            steps {
                git url: 'git@github.com:ORG/REPO.git',
                    credentialsId: 'github-ssh'
            }
        }
    }
}