#!groovy

pipeline {
    agent { docker 'qnib/pytest' }
    stages {
        stage('Build') {
            steps {
                sh 'python --version'
            }
        }
        stage('Static Analysis') {
          steps {
            sh 'flake8 --exit-zero sources > flake8-output.txt || echo "flake8 exited with $?"'
            sh 'cat flake8-output.log'
            warnings parserConfigurations: [[parserName: 'Pep8', pattern: 'flake8-output.log']], failedNewAll: '0', useStableBuildAsReference: true, useDeltaValues: true
          }
          post {
              failure {
                error("Failed Static Analysis. Check warnings for more info.")
              }
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
