# Use the official Apache HTTP Server image as the base image
FROM httpd:latest

# Set the working directory to the Apache document root
WORKDIR /var/www/html

# Copy your custom HTML files into the image
COPY ./* /var/www/html

# (Optional) Expose port 80 if not already exposed by the base image
EXPOSE 80
