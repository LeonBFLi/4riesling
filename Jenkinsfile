pipeline {
    agent any

    stages {
        stage('Clone and Deploy') {
            steps {
                script {
                    // Create a temporary directory for the job
                    def tempDir = pwd()

                    // Change directory to the temporary directory
                    dir(tempDir) {
                        // Explicitly checkout the 'main' branch
                        checkout([$class: 'GitSCM', branches: [[name: 'main']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'CleanBeforeCheckout']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'webserver_cred', url: 'https://github.com/LeonBFLi/riesling_site.git']]])

                        // Move contents to the root of the workspace
                        sh 'mv * $WORKSPACE/'

                        // Copy files to the target server using SCP
                        sh 'scp -rp * root@3.27.239.89:/var/www/html/'

                        // Clean up temporary directory
                        sh 'rm -rf *'
                    }

                    // Restart Apache on the target server
                    sh 'ssh root@3.27.239.89 "systemctl restart httpd"'
                }
            }
        }
    }
}

