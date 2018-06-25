FROM php:7-cli

MAINTAINER Jan Bucher <jan@jan-bucher.ch>

# install software that is used by DBDiff
RUN apt-get update && \
    apt-get install -y git-core unzip && \
    rm -rf /var/lib/apt/lists/*

# install php extension for the MySQL connection
RUN docker-php-ext-install pdo pdo_mysql

ENV HOME /home/dbdiff
RUN useradd --create-home --home-dir $HOME dbdiff && chown -R dbdiff:dbdiff $HOME
USER dbdiff

WORKDIR $HOME

# add current directory into the docker container
COPY . ./

# download & install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install- dir=/usr/local/bin --filename=composer
RUN php composer install