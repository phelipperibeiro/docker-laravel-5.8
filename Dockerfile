FROM php:7.3.12-fpm

RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        curl \
        zlib1g-dev \
        libzip-dev \
        zip \
        unzip \
        wget \
        mariadb-client

RUN docker-php-ext-install pdo pdo_mysql zip

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

WORKDIR /var/www
RUN rm -Rf /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#COPY . /var/www
#RUN composer install && \
#    cp .env.example .env && \
#    php artisan key:generate && \
#    php artisan config:cache

RUN ln -s public html

EXPOSE 9000
ENTRYPOINT ["php-fpm"]



