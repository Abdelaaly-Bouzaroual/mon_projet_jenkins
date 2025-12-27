# 1. L'IMAGE DE BASE (Le socle)
# On part d'un Linux très léger (Alpine) qui a déjà Java 17 installé
FROM eclipse-temurin:17-jdk-alpine
# 2. LE DOSSIER DE TRAVAIL
# On crée un dossier '/app' dans le conteneur et on se place dedans
WORKDIR /app

# 3. LES INGRÉDIENTS
# On copie tout ce qu'il y a dans ton dossier actuel (.) vers le dossier du conteneur (.)
COPY . .

# 4. LA CUISSON (Build)
# On compile le code Java à l'intérieur du conteneur
RUN javac Bonjour.java

# 5. LE SERVICE (Start)
# La commande à lancer quand le conteneur démarre
CMD ["java", "Bonjour"]
