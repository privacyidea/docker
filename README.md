This is a small draft build environment to build a docker image for privacyIDEA.

The docker image is a self contained buntu 14.04 with privacyIDEA installed, which will
run on every distribution.

Run it with 

  docker run -d -p 5001:5001 privacyidea/otpserver

Login with "admin"/"test".

You must not use this in productive environment, since it contains fixed encryption keys
and SSL certificate!


