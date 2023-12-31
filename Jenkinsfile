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

                            sh 'sudo su - jenkins_user -c "cd /tmp/jenkins_workstation; scp -rp * root@~/project"'
                        }

                        // Clean up temporary directory
                        sh 'rm -rf /tmp/jenkins_workstation/*'
                    }
                }
            }
        }

        stage('Restart HTTPD Service') {
            steps {
                script {
                    catchError {
                        sh 'sudo su - -c "ansible-playbook /etc/ansible/restart_httpd.yml"'
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
        }
        failure {
            echo 'Pipeline failed. Review the error message above for troubleshooting.'
        }
    }
}
