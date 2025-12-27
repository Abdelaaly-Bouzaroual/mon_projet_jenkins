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
                sh '''
                    if java Bonjour | grep "DevOps"; then
                        echo "✅ Code valide !"
                    else
                        exit 1
                    fi
                '''
            }
        }

        stage('Construction Image Docker') {
            steps {
                echo '🐳 Construction de l\'image Docker...'
                sh 'docker build -t mon-app-jenkins-v${BUILD_NUMBER} .'
            }
        }

        stage('Déploiement Continu') {
            steps {
                script {
                    echo '🚀 Mise à jour de l\'application...'
                    
                    // 1. On essaie d'arrêter l'ancien conteneur (le "|| true" évite l'erreur si c'est le tout premier lancement)
                    sh 'docker stop mon-app-prod || true'
                    
                    // 2. On supprime l'ancien conteneur
                    sh 'docker rm mon-app-prod || true'
                    
                    // 3. On lance le nouveau !
                    // --name : On lui donne un nom fixe "mon-app-prod" pour pouvoir le retrouver au prochain build
                    // -p 8090:80 : On ouvre le port 8090
                    sh 'docker run -d -p 8090:80 --name mon-app-prod mon-app-jenkins-v${BUILD_NUMBER}'
                }
            }
        }
    }
}
