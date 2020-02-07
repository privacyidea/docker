#!/bin/bash
set -e

. bin/activate

NEW_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
ADMIN_ACCOUNT="${ADMIN_ACCOUNT:-admin@admin.com}"
ADMIN_PASSWORD="${ADMIN_PASSWORD:-$NEW_UUID}"

if [ ! -f /home/pi/etc/privacyidea/enckey ];
then
    pi-manage create_enckey
else
    echo "SKIP: enckey already exists."
fi

if [ ! -f /home/pi/etc/privacyidea/private.pem ];
then
    pi-manage create_audit_keys
else
    echo "SKIP: audit keys already exists."
fi

echo "Creating database..."
until pi-manage createdb; 
do
    echo "Cannot connect to database. Trying again..."
    sleep 3
done

echo "Migrations step..."
pi-manage db stamp head -d lib/privacyidea/migrations

echo "Creating admin account"
pi-manage admin add admin -e "$ADMIN_ACCOUNT" -p "$ADMIN_PASSWORD"

echo "
    You can login with the following credentials:
    email: $ADMIN_ACCOUNT 
    password: $ADMIN_PASSWORD
"

exec "$@"