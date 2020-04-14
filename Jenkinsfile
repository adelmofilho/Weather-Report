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
            sh "R -e 'renv::restore()'"
            
        }
    }
        
    stage('BUild') {
        steps {
            sh "R -e install.package('devtools', repos = 'http://cran.r-project.org')"
            sh "R -e 'devtools::build()'"
            
        }
    }    
        
        
        
    }
}
