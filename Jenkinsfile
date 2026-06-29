pipeline {
    agent any
    stages {
        stage('Global Stage') {

            agent {
                docker {
                    image 'maven:4.0.0-rc-5-amazoncorretto-25-debian-trixie'
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