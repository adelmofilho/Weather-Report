pipeline {
    
    agent any

    stages {
        stage('pre') {
            steps {
                echo env.AWS_ACCESS_KEY_ID
            }
        }
        
        stage('Build') {
            steps {
                sh "docker build -t weatherreport:deploy --build-arg artifacts/"
            }
        }

         stage('Deploy') {
            steps {
                sh "docker run -d weatherreport:deploy"
            }
        }

        
}
}
