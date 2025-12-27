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
                // On garde une compilation locale rapide pour vérifier les erreurs de syntaxe
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
                // Jenkins lance la commande docker build
                sh 'docker build -t mon-app-jenkins-v${BUILD_NUMBER} .'
            }
        }
        
        stage('Nettoyage Docker') {
            steps {
                 // Optionnel : On supprime l'image après pour ne pas remplir le disque
                 // sh 'docker rmi mon-app-jenkins-v${BUILD_NUMBER}'
                 echo 'Image prête !'
            }
        }
    }
}
