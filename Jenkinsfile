pipeline {
    agent {
        label 'android'
    }
    stages {
        stage('clean') {
            steps { 
                echo 'Cleaning..'
                sh 'fastlane run clear_derived_data'
                sh 'fastlane example'
            }
        }
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'fastlane beta'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                // archiveArtifacts '**/*.ipa'
            }
        }
    }
}
