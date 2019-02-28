FROM ubuntu:16.04

# Install apache, PHP, and supplimentary programs. openssh-server, curl, and lynx-cur are for debugging the container.
RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    apache2 php7.0 php7.0-mysql php7.0-xml php7.0-mysql php7.0-curl php7.0-gd php-oauth php7.0-bcmath libapache2-mod-php7.0 curl lynx-cur

# install extras
RUN apt-get -y install multitail

# Enable apache mods.
RUN a2enmod php7.0
RUN a2enmod rewrite

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.0/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ALL/" /etc/php/7.0/apache2/php.ini

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Update apache configuration files
ADD apache-configs/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf
ADD apache-configs/mods-enabled/status.conf /etc/apache2/mods-enabled/status.conf

# By default start up apache in the foreground
COPY apache2-foreground /usr/local/bin/

# Expose apache.
EXPOSE 80

CMD ["apache2-foreground"]
