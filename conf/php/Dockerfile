FROM php:8.1-fpm

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

# Install Redis
RUN pecl install redis && \
docker-php-ext-enable redis

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