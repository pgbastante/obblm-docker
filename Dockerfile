FROM php:5.6-apache
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
WORKDIR /var/www/html/

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        git \
    && docker-php-ext-install -j$(nproc) gd mysql
RUN git clone https://github.com/TheNAF/naflm.git .

RUN chown -R www-data:www-data .

RUN sed -i "s/\$db_name\s*\=\s*'.*';/\$db_name = '$MYSQL_DATABASE';/g" /var/www/html/settings.php
RUN sed -i "s/\$db_user\s*\=\s*'.*';/\$db_user = '$MYSQL_USER';/g" /var/www/html/settings.php
RUN sed -i "s/\$db_passwd\s*\=\s*'.*';/\$db_passwd = '$MYSQL_PASSWORD';/g" /var/www/html/settings.php
RUN sed -i "s/\$db_host\s*\=\s*'.*';/\$db_host = 'mariadb';/g" /var/www/html/settings.php
