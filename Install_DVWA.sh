#!/bin/bash

#===============================================================================
#          FILE:  Install_DVWA.sh
#         USAGE:  ./Install_DVWA.sh
#
#   DESCRIPTION:  Script permettant d'installer DVWA sur Ubuntu serveur 20.04.
#        AUTHOR:  FRANSOIS OLIVIER chayan91300@gmail.com
#       CREATED:  12/07/2020
#===============================================================================

### Variables
USERDB='dvwa'
PASSDB='password'
LEVELUP='low'

### Main

echo -e "\n Merci de choisir une option \n"

# menu
PS3='Votre choix : '
options=("Installation par défaut" "Installation interactive" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Installation par défaut")
            echo "you chose choice 1"
            ;;
        "Installation interactive")
            echo -e "\n Choisir les identifiants de la DB\n"
            read -p "Utilisateur de la DB : " USERDB
            read -p "Mot de passe de la DB : " PASSDB
            echo -e "\n Choisir le niveau de difficulté [low] [medium] [high] [impossible]\n"
            read -p "Niveau : " LEVELUP
            break
            ;;
        "Quit")
            exit 1
            ;;
        *) echo "Attention option invalide $REPLY";;
    esac
done

echo -e "\n Début de l'installation \n"

# Mise à jour et mise en place de LAMP
apt update && apt full-upgrade -y

apt install -y apache2 mariadb-server php
apt install -y php-mysqli php-gd libapache2-mod-php

# Renommer index.html, on ne va pas l'utiliser
mv /var/www/html/index.html /var/www/html/index.html.old

# Téléchargement de DVWA
git -C /var/www/html/ clone https://github.com/ethicalhack3r/DVWA.git

# Configuration de la connexion à la DB 
cp /var/www/html/DVWA/config/config.inc.php.dist /var/www/html/DVWA/config/config.inc.php

sed -i "s/$_DVWA\[ 'db_user' \]     = 'dvwa';/$_DVWA\[ 'db_user' \]     = '${USERDB}';/g" /var/www/html/DVWA/config/config.inc.php
sed -i "s/$_DVWA\[ 'db_password' \] = 'p@ssw0rd';/$_DVWA\[ 'db_password' \] = '${PASSDB}';/g" /var/www/html/DVWA/config/config.inc.php
sed -i "s/$_DVWA\[ 'default_security_level' \] = 'impossible';/$_DVWA\[ 'default_security_level' \] = '${LEVELUP}';/g" /var/www/html/DVWA/config/config.inc.php

# Configuration PHP
sed -i 's/allow_url_include = Off/allow_url_include = On/g' /etc/php/7.4/apache2/php.ini

# Droits en écriture sur ces trois dossiers par Apache2
chown -R www-data:www-data /var/www/html/DVWA/hackable
chown -R www-data:www-data /var/www/html/DVWA/external
chown -R www-data:www-data /var/www/html/DVWA/config

# Création de configuration de la DB
mysql -u root -e "create database dvwa;"
sleep 2
mysql -u root -e "create user ${USERDB}@localhost identified by '${PASSDB}';"
sleep 2
mysql -u root -e "grant all on dvwa.* to ${USERDB}@localhost;"
sleep 2
mysql -u root -e "flush privileges;"

# Redémarrer Apache2
systemctl restart apache2

echo -e "\n Fin de l'installation, accés à la page web : 'http://<IP>/DVWA/setup.php' \n"
