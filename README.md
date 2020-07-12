# Installation de DVWA sur une machine virtuelle sous Ubuntu server 20.04

## Outils nécessaires

|Outil|Version|
|---|---|
|Ubuntu (VM)|20.04 (Focal)|
|DVWA|1.10|
|PHP|7.4|
|Apache|2.4.41|
|MariaDB|10.3|
|Script d'installation|v1|

|Description|Liens utiles|
|---|---|
|Page Github du projet DVWA|https://github.com/ethicalhack3r/DVWA|
|Image Ubuntu server 20.04|https://mirrors.ircam.fr/pub/ubuntu/releases/focal/ubuntu-20.04-live-server-amd64.iso|

Deux mode d'installation :
* Installation par défaut (automatique)
* Installation interactive

## l'installation interactive

* Permet de déterminer un nom pour l'utilisateur de la base de donnée dvwa et un mot de passe.
* Permet aussi de choisir le niveau de difficulté.

## L'installation par défaut

C'est une installation entièrement automatique qui utilise la configuration suivante :

  * Utilisateur de la base de données : dvwa
  * Mot de passe de la base de donnée : password
  * Niveau de difficulté : low

## Lancement de l'installation

Se connecter en tant que root:

`sudo su`

Donner les droits d'exécution au script :

`chmod +x Install_DVWA.sh`

Exécution du script :

`./Install_DVWA.sh`

Choisir le mode d'installation

Fin de l'installation

:warning: **Informations importantes**

* Le script doit être lancé en super utilisateur.
* L'installation a été testé seulement sur ubuntu serveur 20.04.

## Connection sur la page web

Page de configuration :

> http://'IP'/DVWA/setup.php

Appuyer sur le bouton : "Create / Reset Database"

![config](https://github.com/DOSSANTOSDaniel/Install_DVWA/blob/master/Images/config.png)

Page de login.

![login](https://github.com/DOSSANTOSDaniel/Install_DVWA/blob/master/Images/login.png)
