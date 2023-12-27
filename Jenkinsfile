pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout the source code from the Git repository
                    git 'https://github.com/LeonBFLi/riesling_site.git'
                }
            }
        }
        stage('Deploy to Webserver') {
            steps {
                script {
                    // Use SSH to copy files to the Webserver
                    sshagent(credentials: ['webserver_cred']) {
                        sh 'scp -r ./web-content/* ec2-user@webserver-ip:/path/to/webserver/'
                    }
                }
            }
        }
    }
}
