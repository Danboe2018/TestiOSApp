pipeline {
    agent {
        label 'android'
    }
    stages {
        stage('clean') {
            steps { 
                echo 'Cleaning..'
                sh 'fastlane run clear_derived_data'
            }
        }
        stage('Build') {
            steps {
                echo 'Building..'
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
