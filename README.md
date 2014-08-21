This is a small draft build environment to build a docker image for privacyIDEA.

The image
=========

The docker image is a self contained Ubuntu 14.04 with privacyIDEA installed, which will
run on every distribution.

Run it with 

  docker run -d -p 5001:5001 privacyidea/otpserver

This will download the existing privacyIDEA container from the docker hub
https://registry.hub.docker.com/u/privacyidea/otpserver/
and run it.

Login to http://localhost:5001 with "admin@admin"/"test".

You must not use this in productive environment, since it contains fixed encryption keys
and SSL certificate!

Building
========

To build the docker image, you must be root, since the result is written to
/var/lib/docker...


