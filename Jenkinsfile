pipeline {
    
    agent any
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