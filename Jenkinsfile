pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                xcodebuild
            }
        }
    }
    post {
        always {
            junit 'build/reports/**/*.xml'
        }
    }
}
