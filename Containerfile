# Use the official Apache HTTP Server image as the base image
FROM nginx:latest

# Set the working directory to the Apache document root
WORKDIR /usr/share/nginx/html

# Copy your custom HTML files into the image. You have to use '.' in order to perserver the file stuctures.
COPY . /usr/share/nginx/html

# Restart Apache service 


