pipeline {
    
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION    = credentials('AWS_DEFAULT_REGION')
    }
    stages {
        stage('Build') {
            steps {
                sh "docker build -t weatherreport:deploy artifacts/"
            }
        }

         stage('Deploy') {
            steps {
                sh "docker run -d weatherreport:deploy"
            }
        }

        
}
}
