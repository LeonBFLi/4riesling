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

                            sh 'sudo cd /tmp/jenkins_workstation; whoami; scp -o StrictHostKeyChecking=no -rp * root@54.206.15.84:~/project'
                        }

                        // Clean up temporary directory
                        sh 'rm -rf /tmp/jenkins_workstation/*'
                    }
                }
            }
        }

        stage('Check container sitautions') {
            steps {
                script {
                    catchError {
                        sh 'sudo su - -c "podman ps"'
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
