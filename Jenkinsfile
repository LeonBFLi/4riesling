pipeline {
    agent any


    environment {
        SSH_KEY = credentials('ec2-user')
        HOST = 'prod'
    }
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
                                userRemoteConfigs: [[credentialsId: 'prod', url: 'https://github.com/LeonBFLi/riesling_site.git']]
                            ])

                            sh 'sudo cd /tmp/jenkins_workstation; sudo chmod -R 755 /tmp/jenkins_workstation/*; sudo scp -o StrictHostKeyChecking=no -rp /tmp/jenkins_workstation/* root@prod:~/project'
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
                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-user', keyFileVariable: 'SSH_KEY')]) {
                            sh 'eval $(ssh-agent -s)'
                            sh 'ssh-add $SSH_KEY'
                            sh """ssh -o StrictHostKeyChecking=no -i \${SSH_KEY} ec2-user@${HOST} 'sudo su - -c "ansible-playbook -i /etc/ansible/inventory /etc/ansible/build_n_deploy_container.yml"'"""
                        }//withCredentials
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
