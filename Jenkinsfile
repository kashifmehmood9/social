pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                sh 'xcodebuild -allowProvisioningUpdates'
            }
        }
    }
    post {
        always {
            junit 'build/reports/**/*.xml'
        }
    }
}
