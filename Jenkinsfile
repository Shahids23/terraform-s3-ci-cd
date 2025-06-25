pipeline {
    agent any

    environment {
        TF_WORKING_DIR = "./"
        AWS_DEFAULT_REGION = "us-east-1"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "📦 Starting Checkout Stage..."
                git url: 'https://github.com/Shahids23/terraform-s3-ci-cd', branch: 'main'
                echo "✅ Checkout Stage completed successfully."
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                echo "🚀 Starting Terraform Init & Plan Stage..."
                withAWS(credentials: '084828603029', region: "${env.AWS_DEFAULT_REGION}") {
                    dir("${env.TF_WORKING_DIR}") {
                        bat 'terraform init'
                        echo "✅ Terraform init completed."

                        bat 'terraform validate'
                        echo "✅ Terraform validate completed."

                        bat 'terraform plan -out=tfplan'
                        echo "✅ Terraform plan completed."
                    }
                }
                echo "🎯 Terraform Init & Plan Stage completed successfully."
            }
        }

        stage('Terraform Apply') {
            steps {
                echo "🚧 Starting Terraform Apply Stage..."
                withAWS(credentials: '084828603029', region: "${env.AWS_DEFAULT_REGION}") {
                    dir("${env.TF_WORKING_DIR}") {
                        bat 'terraform apply -auto-approve tfplan'
                        echo "✅ Terraform apply completed."
                    }
                }
                echo "🎯 Terraform Apply Stage completed successfully."
            }
        }
    }

    post {
        always {
            echo "🧹 Pipeline completed. Cleaning up..."
        }
        success {
            echo "✅✅✅ Terraform deployment completed successfully!"
        }
        failure {
            echo "❌❌❌ Terraform deployment failed. Check the above stage logs for error details."
        }
    }
}
