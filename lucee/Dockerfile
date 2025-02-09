# Use the lightweight Lucee 6.2 image
FROM lucee/lucee:6.2.1.4-SNAPSHOT-light
# lucee/lucee:6.2.1.4-SNAPSHOT
# lucee/lucee:6.2-light

# Set environment variables (optional)
ENV LUCEE_ADMIN_PASSWORD=${LUCEE_ADMIN_PASSWORD}
ENV LUCEE_JAVA_OPTS="-Xms256m -Xmx512m"

# Create and set working directory
WORKDIR /var/www

# Copy local application files to container
#COPY ./www /var/www

# Expose Lucee’s default web port
#EXPOSE 8888

# Extensions
#ADD https://ext.lucee.org/lucee.admin.extension-1.0.0.5.lex /opt/lucee/server/lucee-server/deploy/
#ADD https://ext.lucee.org/redis.extension-3.0.0.48.lex /opt/opt/lucee/server/lucee-server/deploy
#ADD https://ext.lucee.org/org.lucee.websocket.extension-1.0.0.11-RC.lex /opt/lucee/server/lucee-server/deploy/

# Quartz Sceduler Extenstion
COPY ./org.lucee.quartz.extension-1.0.0.27.lex /opt/lucee/server/lucee-server/deploy/


# Lucee Config
COPY ./lucee-config.json /opt/lucee/server/lucee-server/context/.CFConfig.json

# Start Lucee (Tomcat)
CMD ["catalina.sh", "run"]

###
# cat /opt/lucee/server/lucee-server/context/.CFConfig.json