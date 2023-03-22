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
    libicu-dev \
    libssl-dev


# Install & enable Opcache first (to have Opcache & Xdebug work at the same time, jit compiler will not work though)
RUN docker-php-ext-install opcache \
&& echo "[opcache] \n\
opcache.enable=1 \n\
opcache.enable_cli=1 \n\
opcache.memory_consumption=256 \n\
opcache.interned_strings_buffer=8 \n\
opcache.max_accelerated_files=5000 \n\
opcache.revalidate_freq=5 \n\
opcache.fast_shutdown=1 \n\
opcache.validate_timestamps=1 \n\
opcache.jit=tracing \n\
opcache.jit_buffer_size=256M" >> $PHP_INI_DIR/conf.d/docker-php-ext-opcache.ini

# Install Redis & Xdebug
RUN pecl install redis \
&& pecl install xdebug-3.2.0 \
&& docker-php-ext-enable redis xdebug \
&& echo "xdebug.mode=develop,debug" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
&& echo "xdebug.client_host=host.docker.internal" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini

# Enable Process Control support pcntl
RUN docker-php-ext-configure pcntl --enable-pcntl

# Install PHP extensions
RUN docker-php-ext-install pdo_pgsql intl pcntl

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