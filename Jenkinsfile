pipeline {
    agent any

    stages {
        stage('Nettoyage') {
            steps {
                sh 'rm -f *.class *.jar'
            }
        }

        stage('Build & Test Java') {
            steps {
                echo 'Vérification du code Java...'
                sh 'javac Bonjour.java'
            }
        }

        // --- NOUVELLE ÉTAPE ---
        stage('Analyse Qualité (SonarQube)') {
            steps {
                script {
                    // On récupère l'outil qu'on vient d'installer
                    def scannerHome = tool 'SonarScanner'
                    
                    // On lance l'analyse en utilisant le serveur "sonar-server" configuré tout à l'heure
                    withSonarQubeEnv('sonar-server') {
                        sh "${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=mon-projet-jenkins \
                        -Dsonar.sources=. \
                        -Dsonar.java.binaries=."
                    }
                }
            }
        }
        // ----------------------

        stage('Construction Image Docker') {
            steps {
                sh 'docker build -t mon-app-jenkins-v${BUILD_NUMBER} .'
            }
        }

        stage('Déploiement Continu') {
            steps {
                script {
                    sh 'docker stop mon-app-prod || true'
                    sh 'docker rm mon-app-prod || true'
                    sh 'docker run -d -p 8090:80 --name mon-app-prod mon-app-jenkins-v${BUILD_NUMBER}'
                }
            }
        }
    }
}
