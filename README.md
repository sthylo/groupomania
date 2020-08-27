# Projet n°07 OpenClassrooms

## Création d'un réseau social d'entreprise pour Groupomania

Télécharger le repository et suivez les instructions ci-après pour installer ce projet en local

## prérequis

* Installer Node.js
* Installer Vue.js
* Installer MySQL

## Base de données MySQL

* Ouvrez votre terminal
* Connectez-vous à MySQL : `mysql -h localhost -u root -p`
* Tapez votre mot de passe 
* Créez la base de données : `CREATE DATABASE groupomania_database CHARACTER SET 'utf8';`
* Importez le fichier groupomania_database.sql : `SOURCE groupomania_database.sql;`
* Utilisez la base de données créée : `USE groupomania_database`
* Dans le dossier backend, allez dans le fichier connectdb.js et renseignez votre mot de passe dans password:'xxxxxx'

## Installation et démarrage du Backend

* Ouvrez votre terminal
* Allez dans le dossier backend : `cd groupomania-master/backend` 
* Installez toutes les dépendances du projet : `npm install`
* Démarrez le serveur Node.js : `nodemon server`

## Installation et démarrage du Frontend

* Ouvrez votre terminal
* Allez dans le dossier frontend : `cd groupomania-master/frontend` 
* Installez toutes les dépendances du projet : `npm install`
* Démarrez l'application : `npm run serve`

## Testez l'application
* Ouvrez votre navigateur et allez sur : `http://localhost:8080/`


