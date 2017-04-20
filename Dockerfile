FROM php:7.0-cli
MAINTAINER Dieter Provoost <dieter.provoost@marlon.be>

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    ant \
    sqlite3 \
    curl \
    zlib1g-dev \
    libicu-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Brussels /etc/localtime
RUN "date"

# Type docker-php-ext-install to see available extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install pdo pdo_mysql zip bcmath intl gd pcntl

# PHP Developer configuration
ADD developer.ini /usr/local/etc/php/conf.d/developer.ini
