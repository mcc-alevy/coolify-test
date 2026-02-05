# Use the official Node.js image as a base image
FROM node:24-bookworm

RUN apt-get update && apt-get install -y \
    unixodbc \
    unixodbc-dev \
    build-essential \
    curl \
    samba \
    lib32z1 \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest

# Set environment variables for Actian Zen installation path
ENV ACTIANZEN_ROOT=/usr/local/actianzen
ENV PATH=$PATH:$ACTIANZEN_ROOT/bin:/bin:/usr/bin
ENV LD_LIBRARY_PATH=$ACTIANZEN_ROOT/lib64:$ACTIANZEN_ROOT/lib:$ACTIANZEN_ROOT/bin:/usr/lib
ENV MANPATH=$MANPATH:$ACTIANZEN_ROOT/man

RUN mkdir -p /usr/local
WORKDIR /usr/local

# Copy the Actian Zen client tar file into the container
COPY Zen-Client-linux-x86_64-14.21.031.000.tar.gz .

# Extract and run the Actian Zen client installation scripts
RUN tar -zxf Zen-Client-linux-x86_64-14.21.031.000.tar.gz

# Run pre-install and post-install scripts as specified by Actian documentation
RUN ./actianzen/etc/clientpreinstall.sh
RUN ./actianzen/etc/clientpostinstall.sh

RUN cp ./actianzen/etc/odbcinst.ini /etc/odbcinst.ini

# Clean up the installation files
RUN rm Zen-Client-linux-x86_64-14.21.031.000.tar.gz

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code into the container
COPY . .

RUN rm Zen-Client-linux-x86_64-14.21.031.000.tar.gz

RUN npm run build

RUN npm prune --production

ENV NODE_ENV=production

# Expose the port that the app will run on
EXPOSE 3000

# Define the command to run the app
CMD ["node", "build/index.js"]
