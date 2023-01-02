FROM php:8.2-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpq-dev \
    libicu-dev

# Install Redis & Xdebug
RUN pecl install redis \
&& pecl install xdebug-3.2.0 \
&& docker-php-ext-enable redis xdebug \
&& echo "xdebug.mode=develop,debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
&& echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Install PHP extensions
RUN docker-php-ext-install pdo_pgsql intl

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
	mkdir -p /home/$user/projects && \
	chown -R $user:$user /home/$user

# Set working directory
WORKDIR /home/$user/projects

USER $user