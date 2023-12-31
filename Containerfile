# Use the official Apache HTTP Server image as the base image
FROM httpd:latest

# Set the working directory to the Apache document root
WORKDIR /var/www/html

# Copy your custom HTML files into the image
COPY ./* /var/www/html

# Restart Apache service
CMD ["apachectl", "graceful"]

