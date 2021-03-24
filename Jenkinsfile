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

        stage('Test Log') {
          environment {
            LocalVariable = 'Hello Local Variable'
          }
          steps {
            writeFile(file: 'LogFileTest.txt', text: "Global Variables: ${ChromeDriverPath}, Local Variable: ${LocalVariable}")
          }
        }

      }
    }

    stage('Deployment Build') {
      parallel {


        stage('Deployment') {
          when {
            branch 'develop'
          }

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
      parallel {
        stage('Post Deployment') {
          steps {
            echo 'This is final stage?'
            input(message: 'Do you continue Deployment??', id: 'OK')
          }
        }

        stage('Artifacts') {
          steps {
            archiveArtifacts 'LogFileTest.txt'
          }
        }

      }
    }

  }
  environment {
    ChromeDriverPath = '/var/www/etc'
    Name = 'Mehedi Hasan'
  }
}