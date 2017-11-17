#! /bin/bash

NEW_OWNCLOUD_USERNAME=$1
NEW_OWNCLOUD_UID=$2
NEW_OWNCLOUD_GROUPNAME=$3
NEW_OWNCLOUD_GID=$4

echo "Anlegen der neuen User und Gruppen..."
addgroup --gid $NEW_OWNCLOUD_GID $NEW_OWNCLOUD_GROUPNAME
adduser --uid $NEW_OWNCLOUD_UID --ingroup $NEW_OWNCLOUD_GROUPNAME --no-create-home --disabled-password --disabled-login --gecos "" $NEW_OWNCLOUD_USERNAME
