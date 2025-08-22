pipeline {
    agent any

    environment {
        ARM_TENANT_ID       = credentials('ARM_TENANT_ID')
        ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
        ARM_CLIENT_ID       = credentials('ARM_CLIENT_ID')
        ARM_CLIENT_SECRET   = credentials('ARM_CLIENT_SECRET')
        ADMIN_PASSWORD      = credentials('VMSS_ADMIN_PASSWORD')
    }

    parameters {
        choice(
            name: 'ACTION',
            choices: ['APPLY', 'DESTROY_ALL', 'DESTROY_BUDGET_ONLY'],
            description: 'Choose Terraform action'
        )
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
            steps {
                sh 'terraform init -reconfigure'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Apply/Destroy') {
            steps {
                script {
                    if (params.ACTION == 'APPLY') {
                        sh """
                          terraform plan -out=tfplan \
                            -var subscription_id=$ARM_SUBSCRIPTION_ID \
                            -var client_id=$ARM_CLIENT_ID \
                            -var client_secret=$ARM_CLIENT_SECRET \
                            -var tenant_id=$ARM_TENANT_ID \
                            -var admin_password=$ADMIN_PASSWORD
                        """
                        input message: 'Do you want to apply the changes?', ok: 'Apply'
                        sh 'terraform apply -auto-approve tfplan'
                    }
                    else if (params.ACTION == 'DESTROY_ALL') {
                        input message: 'Do you want to destroy ALL resources?', ok: 'Destroy All'
                        sh """
                          terraform destroy -auto-approve \
                            -var subscription_id=$ARM_SUBSCRIPTION_ID \
                            -var client_id=$ARM_CLIENT_ID \
                            -var client_secret=$ARM_CLIENT_SECRET \
                            -var tenant_id=$ARM_TENANT_ID \
                            -var admin_password=$ADMIN_PASSWORD
                        """
                    }
                    else if (params.ACTION == 'DESTROY_BUDGET_ONLY') {
                        input message: 'Do you want to destroy ONLY the budget alert?', ok: 'Destroy Budget'
                        sh """
                          terraform destroy -auto-approve \
                            -target=azurerm_consumption_budget_resource_group.budget \
                            -var subscription_id=$ARM_SUBSCRIPTION_ID \
                            -var client_id=$ARM_CLIENT_ID \
                            -var client_secret=$ARM_CLIENT_SECRET \
                            -var tenant_id=$ARM_TENANT_ID \
                            -var admin_password=$ADMIN_PASSWORD
                        """
                    }
                }
            }
        }

        stage('Terraform Outputs') {
            when {
                expression { params.ACTION == 'APPLY' }
            }
            steps {
                sh 'terraform output'
            }
        }
    }
}
