# Stage 1: Build stage
FROM ubuntu:latest AS builder

RUN apt-get update && apt-get install -y nginx

# Copy your HTML file into the container
COPY index.html /var/www/html/

# Stage 2: Final stage
FROM ubuntu:latest

# Copy necessary files from the builder stage
COPY --from=builder /usr/sbin/nginx /usr/sbin/nginx
COPY --from=builder /var/www/html/index.html /var/www/html/index.html

# Expose port 80 to allow access to the Nginx web server
EXPOSE 80

# Start the Nginx service when the container runs
CMD ["nginx", "-g", "daemon off;"]
