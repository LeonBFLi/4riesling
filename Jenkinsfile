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

                            sh 'sudo cd /tmp/jenkins_workstation; sudo chmod -R 755 *; sudo scp -o StrictHostKeyChecking=no -rp * .* root@54.206.15.84:~/project
'
                        }

                        // Clean up temporary directory
                        sh 'rm -rf /tmp/jenkins_workstation/*'
                    }
                }
            }
        }

        stage('Trigger Ansible deployment') {
            steps {
                script {
                    catchError {
                        sh 'sudo su - -c "ansible-playbook /etc/ansible/build_n_deploy_container.yml"'
                    }//catchError
                }//script
            }//steps
        }//stage

        stage('Clearn up prodserver env') {
            steps {
                script {
                    catchError {
                        sh 'ssh root@prod "rm -rf ~/project/*"'
                    }//catchError
                }//script
            }//steps
        }//stage
        
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
