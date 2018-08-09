#!/usr/bin/env sh
#

echo "=========== DOCKER ENTRYPOINT OUTPUT ========================"

# Apply database migrations
echo "Activating venv..."
echo "============================================================="
. $PRIVACYIDEA_HOME/venv/bin/activate
export LD_LIBRARY_PATH=/usr/lib:${PYTHON_DIR}/lib

echo "Creating DB..."
echo "============================================================="
pi-manage createdb || exit 1
echo "Apply database migrations"
echo "============================================================="
pi-manage db stamp 4f32a4e1bf33 -d "$PRIVACYIDEA_HOME/venv/lib/privacyidea/migrations" || exit 1
pi-manage db upgrade -d "${PRIVACYIDEA_HOME}/venv/lib/privacyidea/migrations" || exit 1
echo "Adding admin user..."
echo "============================================================="
pi-manage admin add -p ${PI_ADMIN_PASSWORD} ${PI_ADMIN_USER} || exit 1

if [ "$PI_AUDIT_KEY_PRIVATE_SECRET" == "" ]
then
  echo "Generating audit keys..."
  echo "============================================================="
  pi-manage create_audit_keys || exit 1
else
  echo "Private audit key present in secret, setting to file..."
  echo "============================================================="
  echo "$PI_AUDIT_KEY_PRIVATE_SECRET"|base64 -d > $PI_AUDIT_KEY_PRIVATE
  echo "Generating public audit key from private key..."
  echo "============================================================="
  echo "Running command: openssl rsa -in $PI_AUDIT_KEY_PRIVATE -pubout -out $PI_AUDIT_KEY_PUBLIC"
  echo "============================================================="
  openssl rsa -in $PI_AUDIT_KEY_PRIVATE -pubout -out $PI_AUDIT_KEY_PUBLIC || exit 1
fi

if [ "$PI_ENCFILE_SECRET" == "" ]
then
  echo "Generating encryption key..."
  echo "============================================================="
  pi-manage create_enckey || exit 1
else
  echo "Encryption key already present in secret, setting to file..."
  echo "============================================================="
  echo -n "$PI_ENCFILE_SECRET"|base64 -d > $PI_ENCFILE
fi

# Start server
echo "Starting server..."
echo "============================================================="
$PRIVACYIDEA_HOME/python/bin/uwsgi \
    --home $PRIVACYIDEA_HOME/venv \
    --manage-script-name \
    --mount /=privacyidea.app:heroku_app

echo "=========== DOCKER ENTRYPOINT OUTPUT END ========================"
