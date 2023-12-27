pipeline {
    agent any
    
    stages {
        stage('Example') {
            steps {
                sshagent(credentials: ['webserver_cred']) {
                    sh 'ssh root@3.27.239.89 && echo 1'
                }
            }
        }
    }
}
