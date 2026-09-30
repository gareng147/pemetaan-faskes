FROM php:8.2-fpm

# Install dependensi sistem & ekstensi PostgreSQL/PostGIS
RUN apt-get update && apt-get install -y \
    libpq-dev \
    zip unzip git curl \
    && docker-php-ext-install pdo pdo_pgsql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY . .

# Install paket Laravel
RUN composer install --no-dev --optimize-autoloader

EXPOSE 8000

# Jalankan server
CMD php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=8000