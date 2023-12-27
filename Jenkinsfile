pipeline {
    agent any
    
    stages {
        stage('Example') {
            steps {
                sshagent(credentials: ['webserver_cred']) {
                    sh 'echo 1'
                }
            }
        }
    }
}
