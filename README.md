This is a small draft build environment to build a docker image for privacyIDEA.

The image
=========

Run it with 

  docker run -d -p 5001:5000 privacyidea/otpserver

Login to http://localhost:5000 with "admin"/"admin".

Create mssql database: docker-compose exec mssql sh -c '/opt/mssql-tools/bin/sqlcmd -U "$SA_USER" -P "$SA_PASSWORD" -Q "create database pi"'

You must not use this in productive environment, since it contains fixed encryption keys
and SSL certificate!

