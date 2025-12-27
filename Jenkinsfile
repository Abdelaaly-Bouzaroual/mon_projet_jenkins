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

     stage('Construction & Push Nexus') {
            steps {
                script {
                    echo '📦 Construction et Envoi vers Nexus...'
                    
                    // On récupère les identifiants 'nexus-auth' qu'on vient de créer
                    withCredentials([usernamePassword(credentialsId: 'nexus-auth', usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASS')]) {
                        
                        // 1. Login (On se connecte à l'entrepôt)
                        sh "docker login -u ${NEXUS_USER} -p ${NEXUS_PASS} localhost:8083"
                        
                        // 2. Build (On construit en précisant l'adresse de destination)
                        // Note le tag : localhost:8083/nom-image
                        sh "docker build -t localhost:8083/mon-app-jenkins-v${BUILD_NUMBER} ."
                        
                        // 3. Push (On envoie le paquet !)
                        sh "docker push localhost:8083/mon-app-jenkins-v${BUILD_NUMBER}"
                    }
                }
            }
        }

 stage('Déploiement Continu') {
            steps {
                script {
                    echo '🚀 Déploiement de l\'image depuis le registre...'
                    sh 'docker stop mon-app-prod || true'
                    sh 'docker rm mon-app-prod || true'
                    
                    // CORRECTION ICI : On utilise le nom complet (localhost:8083/...)
                    sh 'docker run -d -p 8090:80 --name mon-app-prod localhost:8083/mon-app-jenkins-v${BUILD_NUMBER}'
                }
            }
        }
    }
}
