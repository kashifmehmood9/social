pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                xcode build
            }
        }
    }
    post {
        always {
            junit 'build/reports/**/*.xml'
        }
    }
}
