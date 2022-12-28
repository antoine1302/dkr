FROM node:14.17

# Arguments defined in docker-compose.yml
ARG user

# Install system dependencies
RUN apt-get update && apt-get install -y
# wget gnupg \
#  && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
#  && apt-get update \
#  && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
#    --no-install-recommends

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install puppeteer so it's available in the container.
# RUN npm i puppeteer

# Install create-react-app gloabally
RUN yarn global add create-react-app
# Add Yarn install location to your PATH
RUN export PATH="$(yarn global bin):$PATH"

# Set working directory
WORKDIR /home/$user

USER $user