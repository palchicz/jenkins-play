#!groovy

pipeline {
    agent { docker 'qnib/pytest' }
    stages {
        stage('Build') {
            steps {
                sh 'python --version'
            }
        }
        stage('Test') {
          steps {
            sh 'mkdir -p test-reports'
            sh 'nosetests -s --with-xunit --xunit-fil=test-reports/results.xml sources/test_thing.py'
          }
          post {
            always { junit 'test-reports/results.xml' }
          }
        }
    }
}
