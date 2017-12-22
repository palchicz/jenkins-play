pipeline {
    agent { docker 'python:3.5.1' }
    stages {
        stage('Build') {
            steps {
                sh 'python --version'
            }
        }
        stage('Test') {
          agent { docker 'qnib/pytest' }
          steps {
            dir ('test-reports')
            sh 'nosetests -s --with-xunit --xunit-fil=test-reports/results.xml sources/test_thing.py'
          }
        }
    }
}
