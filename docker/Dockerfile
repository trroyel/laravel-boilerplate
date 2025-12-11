# docker/Dockerfile

FROM php:8.2-fpm-bullseye

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libpng-dev \
    libonig-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    libpq-dev \
    mariadb-client \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl gd

# Install composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Create app directory
WORKDIR /var/www/html

# Copy entrypoint script with executable permission
COPY --chmod=755 docker/docker-entrypoint.sh /var/www/html/docker/docker-entrypoint.sh

# Copy the Laravel project files
COPY . .

# Give permissions for Laravel
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 storage bootstrap/cache

# Expose PHP-FPM port
EXPOSE 9000

# Use the entrypoint script
ENTRYPOINT ["/var/www/html/docker/docker-entrypoint.sh"]

# Run php-fpm as main process
CMD ["php-fpm"]
