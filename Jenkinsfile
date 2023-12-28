pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    def tempDir = '/tmp/jenkins_workstation'

                    catchError {
                        dir(tempDir) {
                            checkout([
                                $class: 'GitSCM',
                                branches: [[name: 'main']],
                                doGenerateSubmoduleConfigurations: false,
                                extensions: [[$class: 'CleanBeforeCheckout']],
                                submoduleCfg: [],
                                userRemoteConfigs: [[credentialsId: 'webserver_cred', url: 'https://github.com/LeonBFLi/riesling_site.git']]
                            ])

                            sh 'sudo su - jenkins_user -c "cd /tmp/jenkins_workstation; scp -rp * root@3.27.239.89:/var/www/html/"'
                        }

                        // Clean up temporary directory
                        sh 'rm -rf *'
                    }
                }
            }
        }

        stage('Restart HTTPD Service') {
            steps {
                script {
                    catchError {
                        sh 'sudo su - jenkins_user -c "ssh root@3.27.239.89 \'systemctl restart httpd\'"'
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed. Check the Jenkins console output for details.'
        }
        success {
            echo 'Pipeline succeeded. Deployment was successful.'
            
            // Send email notification on success
            emailext subject: 'Pipeline Successful: Deployment Completed',
                      body: 'The deployment pipeline has completed successfully. The web content has been deployed.',
                      to: 'libofan1995@163.com',
                      replyTo: 'jenkins@example.com',
                      mimeType: 'text/html'
        }
        failure {
            echo 'Pipeline failed. Review the error message above for troubleshooting.'
            
            // Send email notification on failure
            emailext subject: 'Pipeline Failed: Deployment Issues',
                      body: 'The deployment pipeline has failed. Please review the Jenkins console output for details.',
                      to: 'libofan1995@163.com',
                      replyTo: 'jenkins@example.com',
                      mimeType: 'text/html'
        }
    }
}
