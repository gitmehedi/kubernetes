pipeline {
  agent any
  stages {
    stage('Build Stage') {
      parallel {
        stage('Build Stage') {
          steps {
            echo 'Build image from Python File'
          }
        }

        stage('Test ') {
          steps {
            echo 'Test the build stage'
          }
        }

      }
    }

    stage('Deployment') {
      parallel {
        stage('Deployment') {
          steps {
            echo 'Deploy the Python Application'
          }
        }

        stage('Test Deployment') {
          steps {
            echo 'Testing the Deployments'
          }
        }

      }
    }

  }
}