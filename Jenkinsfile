#!groovy

def get_static_analysis_warnings_count() {
    return sh(script: "tail -n 1 flake8-output.txt", returnStdout: true).trim()
}

pipeline {
    agent { docker 'palchick/pytest' }
    stages {
        stage('Build') {
            steps {
                sh 'python --version'
            }
        }
        stage('Static Analysis') {
          steps {
            sh 'flake8 --exit-zero --count sources > flake8-output.txt || echo "flake8 exited with $?"'
            sh 'cat flake8-output.txt'

            script {
              FAILURE_THRESHOLD = sh(script: "tail -n 1 .static_analysis_threshold.txt", returnStdout: true).trim()
              warnings parserConfigurations: [[parserName: 'Pep8', pattern: 'flake8-output.txt']], failedTotalAll: "${FAILURE_THRESHOLD}"
            }
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
        stage('Commit') {
          when {
            expression {
              return env.JOB_NAME.contains('master')
            }
          }
          environment {
            warnings_count = get_static_analysis_warnings_count()
          }
          steps {
            sh("sed -i '\$c${warnings_count}' .static_analysis_threshold.txt")
            sh("cat .static_analysis_threshold.txt")
          }
        }
    }
}
