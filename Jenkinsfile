pipeline {
    agent any

    parameters {
        choice(
            name: 'Environnement',
            choices: ['Env1', 'Env2'],
            description: 'Choisir un environnement'
        )
    }

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
                            npm install --save-dev newman
                            npm install --save-dev newman-reporter-allure
                        '''
                    }
                }

                stage('Clean Allure Results') {
                    steps {
                        sh ''''
                            echo "Suppression du cache Allure..."
                            rm -rf target
                            mkdir -p target
                            echo "Dossier target nettoyé avec succès"
                        ''''
                    }
                }

                stage('Run User Test') {
                    steps {

                        sh 'mvn test -Dkarate.options="--tags @tags1"'

                        sh '''
                            echo "Contenu généré :"
                            find target || true
                        '''

                        stash(
                            name: 'target',
                            includes: 'target/**/*',
                            allowEmpty: true
                        )
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                unstash 'target'
            }

            archiveArtifacts(
                artifacts: 'target/**/*',
                allowEmptyArchive: true
            )

            allure(
                includeProperties: false,
                jdk: '',
                results: [[path: 'target']]
            )
        }
    }
}