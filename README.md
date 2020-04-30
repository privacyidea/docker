This is a small draft build environment to build a docker image for privacyIDEA.

## Getting running example

 * Start services

```bash
docker-compose up
```

 * Minimal setup steps

```bash
docker exec -it privacyidea bash               # connect to privacyIDEA docker container
pi-manage createdb                             # create db
pi-manage create_enckey                        # create encryption keys
pi-manage create_audit_keys                    # create signing keys
pi-manage admin add admin -e admin@localhost   # add admin user
```

Check more from [offical docs](https://privacyidea.readthedocs.io/en/latest/) about setup/config.

 * Access privacyIDEA -> [http://localhost:80/](http://localhost:80/)

## Build docker image

```bash
docker build -t $NAME .
```
