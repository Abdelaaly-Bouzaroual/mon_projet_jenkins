pipeline {
    agent any

    stages {
        stage('Nettoyage') {
            steps {
                sh 'rm -f *.class *.jar'
            }
        }

        stage('Build') {
            steps {
                echo 'Compilation du code...'
                sh 'javac Bonjour.java'
            }
        }

        stage('Test') {
            steps {
                sh '''
                    # On lance le programme
                    OUTPUT=$(java Bonjour)
                    
                    # On utilise grep pour chercher le mot "DevOps".
                    # Si grep trouve le mot, il renvoie "vrai" (code 0).
                    if echo "$OUTPUT" | grep "DevOps"; then
                        echo "✅ Test réussi !"
                    else
                        echo "❌ Échec du test : $OUTPUT"
                        exit 1
                    fi
                '''
            }
        }
        stage('Packaging') {
            steps {
                sh 'jar cfe app.jar Bonjour Bonjour.class'
            }
        }

        stage('Déploiement') {
            steps {
                // On utilise la variable BUILD_NUMBER fournie par Jenkins
                sh "cp app.jar /mnt/c/Devops/Production_Server/app_v${BUILD_NUMBER}.jar"
            }
        }
    }
}
