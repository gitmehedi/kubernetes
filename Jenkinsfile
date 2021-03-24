pipeline {
  agent any
  stages {
    stage('Source Build') {
      parallel {
        stage('Build Stage') {
          steps {
            echo 'First stage of building source code'
            sh '''#!/bin/bash
echo "This is a primary stage"'''
          }
        }

        stage('Build Test Stage') {
          steps {
            echo 'First stage of building test'
            echo "Path of name is ${Name}"
          }
        }

      }
    }

    stage('Deployment Build') {
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

    stage('Post Deployment') {
      steps {
        echo 'This is final stage'
        input(message: 'Do you continue Deployment??', id: 'OK')
      }
    }

  }
  environment {
    ChromeDriverPath = '/var/www/etc'
    Name = 'Mehedi Hasan'
  }
}