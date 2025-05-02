pipeline {
    agent any

    environment {
        IMAGE_NAME = "yourdockerhubusername/my-fastapi-app:${BUILD_NUMBER}"
    }

    stages {
        stage('Step 1: Get code from GitHub') {
            steps {
                git 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Step 2: Build Docker image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Step 3: Push Docker image to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh """
                        echo "$PASS" | docker login -u "$USER" --password-stdin
                        docker push ${IMAGE_NAME}
                    """
                }
            }
        }

        stage('Step 4: Deploy to AKS') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: 'azure-creds', clientIdVariable: 'AZ_CLIENT', clientSecretVariable: 'AZ_SECRET', tenantIdVariable: 'AZ_TENANT', subscriptionIdVariable: 'AZ_SUB')]) {
                    sh '''
                    az login --service-principal -u $AZ_CLIENT -p $AZ_SECRET --tenant $AZ_TENANT
                    az aks get-credentials --resource-group your-rg --name your-aks-cluster
                    kubectl set image deployment/fastapi-deployment fastapi-container=${IMAGE_NAME}
                    '''
                }
            }
        }
    }

    triggers {
        githubPush()
    }
}
