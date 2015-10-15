# docker-gitlist
Docker image for gitlist with support for LDAP authentication.

Build and run with:
```bash
docker build -t gitlist .
docker run -d --name gitlist -p 80:80 -v /home/vagrant/workspace:/home/git/repositories/ gitlist && echo "Started"
```

> Note that `/home/vagrant/workspace` should be replaced with the path to git repositories on the host machine.

