FROM php:7.4-apache

# Update package list and install necessary packages
RUN apt-get update && apt-get install -y \
    libicu-dev \
    xz-utils \
    git \
    python3 \
    python3-pip \
    python-is-python3 \
    libgmp-dev \
    unzip \
    ffmpeg \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install intl gmp gettext

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --quiet

# Copy PHP configuration and project files
COPY resources/php.ini /usr/local/etc/php/
COPY . /var/www/html/

# Remove composer.lock if it exists to avoid version constraints
RUN rm -f /var/www/html/composer.lock

# Update the composer.json to require the latest yt-dlp version
RUN php composer.phar config "minimum-stability" "dev" && \
    php composer.phar config "prefer-stable" true && \
    php composer.phar require "yt-dlp/yt-dlp:*" --no-update

# Install Composer dependencies without the lock file
RUN php composer.phar install --prefer-dist --no-progress --no-dev --optimize-autoloader

# Update to the latest version of yt-dlp, ignoring constraints
RUN php composer.phar update yt-dlp/yt-dlp --with-all-dependencies --prefer-dist --no-progress --no-dev --optimize-autoloader

# Check platform requirements
RUN php composer.phar check-platform-reqs --no-dev

# Set permissions for templates directory
RUN mkdir /var/www/html/templates_c/ && \
    chmod 770 -R /var/www/html/templates_c/ && \
    chown www-data -R /var/www/html/templates_c/

# Set environment variable
ENV CONVERT=1
