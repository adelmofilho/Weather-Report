pipeline {
    
    agent {
        docker { image 'adelmofilho/r-base:3.6.2' }
    }
    stages {
        stage('LookUp') {
            steps {
                sh deploy/pre_build.sh
            }
        }
        
    stage('Loo2kUp') {
        steps {
            sh "R -e 'renv::restore()'"
            
        }
    }
        
    stage('BUild') {
        steps {
            
            sh "R -e 'devtools::build()'"
            
        }
    }    
        
        
        
    }
}
