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
            step([
              $class                     : 'WarningsPublisher',
              parserConfigurations       : [[
                                              parserName: 'PYLint',
                                              pattern   : 'pylint.log'
                                            ]],
              failedNewAll               : '0',  // This means that if there are any new violations compared to last stable, fail
              usePreviousBuildAsReference: true
          ])
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
