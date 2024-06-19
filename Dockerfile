# Use Node.js LTS Alpine as base image
FROM node:lts-alpine

# Install simple http server for serving static content
RUN npm install -g http-server

# Make the 'app' folder the current working directory
WORKDIR /app

# Copy both 'package.json' and 'package-lock.json' (if available)
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy all files and folders from 'pewniaczki_ztw' to the current working directory ('/app' folder in the container)
COPY . .

# Build app for production with minification
RUN npm run build

# Expose port 8080
EXPOSE 8080

# Serve the app with http-server from the 'dist' folder
CMD [ "http-server", "dist" ]
