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

# Install Composer dependencies
RUN php composer.phar check-platform-reqs --no-dev
RUN php composer.phar install --prefer-dist --no-progress --no-dev --optimize-autoloader

# Set permissions for templates directory
RUN mkdir /var/www/html/templates_c/ && \
    chmod 770 -R /var/www/html/templates_c/ && \
    chown www-data -R /var/www/html/templates_c/

# Set environment variable
ENV CONVERT=1
