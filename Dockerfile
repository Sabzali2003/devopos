# Use the official Nginx image as a base
FROM nginx:latest

# Copy custom configuration file (optional)
# COPY ./nginx.conf /etc/nginx/nginx.conf

# Copy static website files to Nginx's default document root
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
