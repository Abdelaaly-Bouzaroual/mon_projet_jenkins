# On prend un serveur web léger (Nginx)
FROM nginx:alpine

# On copie notre page web dans le dossier du serveur
COPY index.html /usr/share/nginx/html/index.html

# C'est tout ! Nginx démarre tout seul et reste allumé.
