#!/bin/bash

# Dieses Skript passt die UID und GID aller relevanten Dateien im Container an, damit sie
# mit den gewählten neuen Parametern funktionieren.
# Es muss mit folgenden Parametern in der Umgebung aufgerufen werden:
#
#
# NEW_OWNCLOUD_GID: neue Gruppen-ID
# NEW_OWNCLOUD_UID: neue Benutzer-ID
#

ON_DOCKER=$1

# Ermittle die aktuellen UID und GID

OWNCLOUD_UID=`id -u www-data`
OWNCLOUD_GID=`id -g www-data`

echo "Aktuelle Werte: UID=$OWNCLOUD_UID, GID=$OWNCLOUD_GID"

if [ "$OWNCLOUD_UID" != "$NEW_OWNCLOUD_UID" ] ; then

    echo "Ersetzen der UIDs von owncloud..."
    find /var/www -uid $OWNCLOUD_UID -exec chown $NEW_OWNCLOUD_UID {} \;
    find /var/www -gid $OWNCLOUD_GID -exec chgrp $NEW_OWNCLOUD_GID {} \;

    echo "Löschen der bestehenden User und Gruppen..."
    deluser www-data
    delgroup www-data

    NEW_OWNCLOUD_GROUPNAME=www-data
    NEW_OWNCLOUD_USERNAME=www-data
    
    echo "Anlegen des neuen Users $NEW_OWNCLOUD_UID und der neuen Gruppe $NEW_OWNCLOUD_GID ..."
    addgroup --gid $NEW_OWNCLOUD_GID $NEW_OWNCLOUD_GROUPNAME
    adduser --uid $NEW_OWNCLOUD_UID --ingroup $NEW_OWNCLOUD_GROUPNAME --no-create-home \
	    --disabled-password --disabled-login --gecos "" $NEW_OWNCLOUD_USERNAME
fi
