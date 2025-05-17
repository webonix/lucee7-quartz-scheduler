FROM redis:latest

# Copy custom Redis configuration
COPY ./config/redis.conf /usr/local/etc/redis/redis.conf

# Expose Redis port
EXPOSE 6379

# Set Redis to use the custom config file
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]