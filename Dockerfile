FROM bnorrin/docker-gitlist:0.5.0

# Change the sources for apt because libapache2-mod-authnz-external is not in the main repository
COPY sources.list /etc/apt/sources.list
RUN apt-get update -y --force-yes

# Update the apt package database
RUN apt-get upgrade -y --force-yes

# Install apache2 authnz external module
RUN apt-get install -y --force-yes libapache2-mod-authnz-external

# Enable required modules
RUN a2enmod actions ;\
    a2enmod authnz_ldap ;\
    a2enmod authnz_external ;\
    a2enmod ldap ;\
    a2enmod setenvif

ENTRYPOINT  ["apache2ctl", "-D", "FOREGROUND"]
