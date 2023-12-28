pipeline {
    agent any

    stages {
        stage('Clone and Deploy') {
            steps {
                script {
                    // Create a temporary directory for the job
                    def tempDir = '/tmp/jenkins_workstation'

                    // Change directory to the workstation directory
                    dir(tempDir) {
                        // Explicitly checkout the 'main' branch
                        checkout([$class: 'GitSCM', branches: [[name: 'main']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'CleanBeforeCheckout']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'webserver_cred', url: 'https://github.com/LeonBFLi/riesling_site.git']]])
                    
                        // Copy files to the target server using SCP
                        sh 'sudo su - jenkins_user -c "cd /tmp/jenkins_workstation; scp -rp * root@3.27.239.89:/var/www/html/"'
                    

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

