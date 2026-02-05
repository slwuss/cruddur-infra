pipeline {
    agent {
        docker {
            image 'jenkins/inbound-agent-terraform:1.14'
        }
    }

    environment {
        TF_IN_AUTOMATION = "true"
        TF_INPUT = "false"
        AWS_DEFAULT_REGION = "ap-southeast-2"
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -check -recursive'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Security Scan') {
            steps {
                sh '''
                  if command -v tfsec >/dev/null 2>&1; then
                    tfsec . \
                    --exclude-path terraform/inspect
                  else
                    echo "tfsec not installed, skipping security scan"
                  fi
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-prod']
                ]) {
                    sh '''
                      terraform -chdir=terraform/env/prod init -input=false
                    '''
                }
            }
        }
    

        stage('Terraform Plan') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-prod']
                ]) {
                    sh '''
                      terraform -chdir=terraform/env/prod plan -no-color -out=tfplan
                      terraform -chdir=terraform/env/prod show -no-color tfplan > tfplan.txt
                    '''
                }
            }
        }

        stage('Approve Apply') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Apply Terraform to production?'
            }
        }

        stage('Terraform Apply') {
            when {
                branch 'main'
            }
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-prod']
                ]) {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform pipeline passed ✅'
        }
        failure {
            echo 'Terraform pipeline failed ❌'
        }
        always {
            archiveArtifacts artifacts: 'tfplan,tfplan.txt', onlyIfSuccessful: false
        }
    }
}