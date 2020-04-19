pipeline {
    
    agent any

    stages {
        
        stage('Build') {
            steps {
                export TESTE=env.AWS_ACCESS_KEY_ID
                echo $TESTE
                sh "docker build -t weatherreport:deploy --build-arg AWS_ACCESS_KEY_ID=env.AWS_ACCESS_KEY_ID --build-arg AWS_SECRET_ACCESS_KEY=env.AWS_SECRET_ACCESS_KEY --build-arg AWS_DEFAULT_REGION=env.AWS_DEFAULT_REGION artifacts/"
            }
        }

         stage('Deploy') {
            steps {
                sh "docker run -d weatherreport:deploy"
            }
        }

        
}
}
