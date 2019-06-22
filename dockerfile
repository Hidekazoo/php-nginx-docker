FROM php:7.3-fpm-alpine3.8
RUN apk --update add curl
RUN set -ex \
  && apk --no-cache add \
  postgresql-dev php-pgsql autoconf build-base
RUN pecl install xdebug
RUN docker-php-ext-install pdo_pgsql pgsql
RUN docker-php-ext-enable xdebug
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer