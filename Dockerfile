FROM nginx:1.25-alpine
# Remove default nginx configuration
RUN rm /etc/nginx/conf.d/default.conf
# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Copy static site content
COPY . /usr/share/nginx/html
# Expose port for Cloud Run
EXPOSE 8080
# Run nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
