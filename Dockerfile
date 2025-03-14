FROM php:8.2-fpm-alpine

RUN apk update && apk add --no-cache git zip unzip libzip-dev icu-dev $PHPIZE_DEPS
RUN pecl install zip intl && docker-php-ext-enable zip intl
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/symfony
COPY . /var/www/symfony

RUN composer install --no-dev --optimize-autoloader

EXPOSE 9000
CMD ["php-fpm", "-F"]