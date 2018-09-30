pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                sh 'xcodebuild'
            }
        }
    }
    post {
        always {
            junit 'build/reports/**/*.xml'
        }
    }
}
