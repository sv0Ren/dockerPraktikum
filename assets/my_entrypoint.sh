#!/bin/bash

echo "Teste auf Korrektur der UID und GID"
/move_uid_and_gid.sh

echo "Warten auf Datenbank..."
/usr/local/bin/dockerize -wait tcp://mysql:3306 -timeout 100s

echo "Datenbank OK"
/usr/local/bin/docker-entrypoint.sh $@
