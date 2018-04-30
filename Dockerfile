FROM php:7-cli

MAINTAINER Jan Bucher <jan@jan-bucher.ch>

# install software that is used by DBDiff
RUN apt-get update && \
    apt-get install -y git-core unzip && \
    rm -rf /var/lib/apt/lists/*

# install php extension for the MySQL connection
RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /home/dbdiff

# add current directory into the docker container
COPY . ./

# download & install composer
ADD https://getcomposer.org/composer.phar composer
RUN chmod +x composer
RUN ./composer install
