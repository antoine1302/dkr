FROM golang:1.21.5

# Build Delve
# RUN go install github.com/go-delve/delve/cmd/dlv@latest

EXPOSE 40000	

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
RUN useradd -G root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/projects && \
	chown -R $user:$user /home/$user

# Set working directory
WORKDIR /home/$user/projects

USER $user