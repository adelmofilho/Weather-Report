pipeline {
    
    agent {
        docker { image 'adelmofilho/r-base:3.6.2' }
    }
    stages {
        stage('LookUp') {
            steps {
                sh "ls -lah"
            }
        }
        
    stage('Loo2kUp') {
        steps {
            sh "R -e devtools::build()"
        }
    }
    }
}
