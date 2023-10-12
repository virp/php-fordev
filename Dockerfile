#syntax=docker/dockerfile:1.4

FROM php:8.2-alpine

WORKDIR /app

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN set -eux; \
    chmod +x /usr/local/bin/install-php-extensions; \
    install-php-extensions \
        apcu \
        intl \
        opcache \
        zip \
        xdebug \
    ;

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH="${PATH}:/root/.composer/vendor/bin"
ENV XDEBUG_MODE=develop,debug

COPY --from=composer/composer:2-bin --link /composer /usr/bin/composer