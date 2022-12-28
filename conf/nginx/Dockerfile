FROM nginx:1.19

EXPOSE 80 4000

# Arguments defined in docker-compose.yml
ARG user
ARG uid

RUN apt-get update && apt-get install -y \
	zip \
	unzip \
	vim \
	curl \
	wget

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Create system user
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/projects && \
	chown -R $user:$user /home/$user

# Add ssl to web server
COPY ./snippets /etc/nginx/snippets
COPY ./ssl/certs /etc/ssl/certs
COPY ./ssl/private /etc/ssl/private
COPY ./dhparam/dhparam.pem /etc/nginx
COPY ./conf.d /etc/nginx/conf.d