pipeline {
    agent any
    stages {
        stage('Global Stage') {

            agent {
                docker {
                    image 'maven:3.9.11-eclipse-temurin-21'
                    args '-u root --entrypoint='
                }
            }

            stages {

                stage('Install Dependencies') {
                    steps {
                        sh '''
                            echo "Compilation du projet..."
                            mvn clean compile
                        '''
                    }
                }
                stage('Run User Test') {
                    steps {
                        sh 'mvn test -Dkarate.options="--tags @tags1"'
                    }
                }
            }
        }
    }
}