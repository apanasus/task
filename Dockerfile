FROM php:8.0-fpm
RUN apt-get update && apt-get install -y \
    libpq-dev \
    mysql-client \
    zip \
    unzip
COPY php.ini /usr/local/etc/php/
RUN mv /usr/local/etc/php/php.ini /usr/local/etc/php/conf.d/php.ini

WORKDIR /var/www/app
COPY . /var/www/app

RUN composer install --no-interaction --prefer-dist

RUN groupadd -g 1000 www-data && useradd -u 1000 -g www-data -m www-data

RUN chown -R www-data:www-data /var/www/app

EXPOSE 9000

CMD ["php-fpm"]