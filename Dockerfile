FROM php:7.4-fpm-alpine

MAINTAINER "Rodrigo Gil Lopetegui" <grodrigo.dev+docker@gmail.com>

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
#ARG VERSION-COMPOSER
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Docker composer php" \
      org.label-schema.description="Php fpm for laravel" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/grodrigo/docker-phplaravel.git" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

RUN apk add --no-cache freetype-dev libpng-dev libjpeg-turbo-dev libxml2-dev libzip-dev freetype libpng libjpeg-turbo tzdata \
	&& docker-php-ext-configure zip \
	&& docker-php-ext-install bcmath gd mysqli pcntl pdo pdo_mysql opcache tokenizer xml zip \
	&& apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev libxml2-dev \
	&& rm -rf /var/cache/apk/*

#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer --version=$VERSION-COMPOSER

RUN mkdir -p /var/www

WORKDIR /var/www
