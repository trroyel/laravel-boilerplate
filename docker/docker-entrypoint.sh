#!/bin/bash
set -e

# Ensure storage and cache have correct perms
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Create .env if missing
if [ ! -f /var/www/html/.env ]; then
    cp /var/www/html/.env.example /var/www/html/.env
fi

# Install composer dependencies if vendor missing
if [ ! -d /var/www/html/vendor ]; then
    composer install --prefer-dist --no-progress --no-interaction
fi

# Generate key if missing
if ! grep -q "APP_KEY=base64" /var/www/html/.env; then
    php artisan key:generate
fi

exec "$@"

