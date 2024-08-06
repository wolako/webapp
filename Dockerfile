# Utiliser l'image officielle Node.js pour construire l'application Angular
FROM node:14 AS build

# Définir le répertoire de travail dans le conteneur
WORKDIR /usr/src/app

# Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste du code de l'application
COPY . .

# Construire l'application Angular
RUN npm run build

# Utiliser l'image officielle Nginx pour servir l'application
FROM nginx:alpine

# Copier les fichiers de construction de l'application Angular dans le répertoire de Nginx
COPY --from=build /usr/src/app/dist/contact-form /usr/share/nginx/html

# Exposer le port utilisé par Nginx
EXPOSE 80

# Commande par défaut pour démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
