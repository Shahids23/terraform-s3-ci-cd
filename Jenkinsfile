pipeline {
    agent any

    environment {
        TF_WORKING_DIR = "./"
        AWS_DEFAULT_REGION = "us-east-1"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Shahids23/terraform-s3-ci-cd', branch: 'main'
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                withAWS(credentials: '084828603029', region: "${env.AWS_DEFAULT_REGION}") {
                    dir("${env.TF_WORKING_DIR}") {
                        sh 'terraform init'
                        sh 'terraform validate'
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withAWS(credentials: '084828603029', region: "${env.AWS_DEFAULT_REGION}") {
                    dir("${env.TF_WORKING_DIR}") {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Terraform deployed successfully!"
        }
        failure {
            echo "Terraform deployment failed."
        }
    }
}
