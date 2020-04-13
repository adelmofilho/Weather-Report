pipeline {
    agent any

    stages {
        stage('donde') {
            steps {
                echo $PWD            
            }
        }
        stage('Test') {
            steps {
                 ls -lah
            }
        }
        stage('Deploy') {
            steps {
                ws s3 cp s3://hco-jenkins-bucket/keys_tokens.json  asd.json
            }
        }
    }
}
