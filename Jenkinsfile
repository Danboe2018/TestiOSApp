pipeline {
    agent {
        label 'ios'
    }
    stages {
        stage('clean') {
            steps { 
                wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm']) {
                    echo 'Cleaning..'
                    sh 'fastlane run clear_derived_data'
                    sh 'fastlane example'
                }
            }
        }
        stage('Build') {
            steps {
                wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm']) {
                    echo 'Building..'
                    sh 'fastlane beta'
                    // sh 'xcodebuild -scheme "iOSTestApp" -configuration "Debug" build'
                }
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
