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
                        // Clone the Git repository
                        git url: 'https://github.com/LeonBFLi/riesling_site.git'

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

