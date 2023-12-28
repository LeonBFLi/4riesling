pipeline {
    agent any

    environment {
        TEMP_DIR = '/tmp/jenkins_workstation'
        REPO_URL = 'https://github.com/LeonBFLi/riesling_site.git'
        TARGET_SERVER = 'root@3.27.239.89:/var/www/html/'
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    def repoDir = "${TEMP_DIR}/repository"

                    catchError {
                        // Change directory to the workstation directory
                        dir(repoDir) {
                            checkout([
                                $class: 'GitSCM',
                                branches: [[name: 'main']],
                                doGenerateSubmoduleConfigurations: false,
                                extensions: [[$class: 'CleanBeforeCheckout']],
                                submoduleCfg: [],
                                userRemoteConfigs: [[credentialsId: 'webserver_cred', url: REPO_URL]]
                            ])

                            // Copy files to the target server using SCP
                            sh "sudo su - jenkins_user -c 'cd ${repoDir}; scp -rp * ${TARGET_SERVER}'"
                        }
                    }

                    // Clean up temporary directory, regardless of errors during previous steps
                    sh "rm -rf ${repoDir}"
                }
            }
        }

        stage('Restart HTTPD Service') {
            steps {
                script {
                    catchError {
                        // Restart Apache on the target server
                        sh "sudo su - jenkins_user -c 'ssh ${TARGET_SERVER} \\\'systemctl restart httpd\\\' '"
                    }
                }
            }
        }
    }

    post {
        failure {
            // This block will be executed if any of the previous stages fail
            echo "One or more stages have failed. Check the Jenkins console output for details."
        }
    }
}
