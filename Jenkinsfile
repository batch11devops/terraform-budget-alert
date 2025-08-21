pipeline {
    agent any

    environment {
        ARM_TENANT_ID       = credentials('ARM_TENANT_ID')
        ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
        ARM_CLIENT_ID       = credentials('ARM_CLIENT_ID')
        ARM_CLIENT_SECRET   = credentials('ARM_CLIENT_SECRET')
        TF_ADMIN_PASSWORD   = credentials('VMSS_ADMIN_PASSWORD')  // Secure
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/batch11devops/terraform-budget-alert.git',
                    credentialsId: 'github-credential'
            }
        }

        stage('Terraform Init') {
            steps { sh 'terraform init -reconfigure' }
        }

        stage('Terraform Validate') {
            steps { sh 'terraform validate' }
        }

        stage('Terraform Plan') {
            steps {
                sh "terraform plan -out=tfplan -var 'admin_password=${TF_ADMIN_PASSWORD}'"
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Do you want to apply the changes?', ok: 'Apply'
                sh "terraform apply -auto-approve tfplan"
            }
        }
    }
}
