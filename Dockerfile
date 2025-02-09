FROM redis:latest

# Copy custom Redis configuration (if any)
COPY ./config/redis.conf /usr/local/etc/redis/redis.conf

# Expose Redis port
EXPOSE 6379

# Start Redis with config file
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
