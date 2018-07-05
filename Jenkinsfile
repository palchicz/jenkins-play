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
            sh 'pylint --disable=W1202 --output-format=parseable --reports=no sources/ > pylint.log || echo "pylint exited with $?"'
            sh 'cat pylint.log'
            warnings parserConfigurations: [[parserName: 'pYLint', pattern: 'pylint.log']], failedNewAll: '0', useStableBuildAsReference: true, useDeltaValues: true
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
