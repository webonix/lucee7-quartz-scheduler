ARG LUCEE_VERSION
ARG LUCEE_ADMIN_PASSWORD

# Use the lightweight Lucee 6.2 image
FROM lucee/lucee:${LUCEE_VERSION}
# FROM lucee/lucee:6.2.1.4-SNAPSHOT
# FROM lucee/lucee:6.2-light

# Set environment variables (optional)
ENV LUCEE_ADMIN_PASSWORD=${LUCEE_ADMIN_PASSWORD}
ENV LUCEE_JAVA_OPTS="-Xms256m -Xmx512m"

# Create and set working directory
#WORKDIR /var/www
# Set working directory to Lucee's default path
#WORKDIR /opt/lucee

# Copy local application files to container
#COPY ./www /var/www

# Expose Lucee’s default web port
#EXPOSE 8888

# Ensure the deploy directory exists
#RUN mkdir -p /opt/lucee/server/lucee-server/deploy/

# Pre-warm Lucee by starting Tomcat
#RUN /bin/bash -c "catalina.sh start && \
#                  sleep 15 && \
#                  catalina.sh stop"


# Extensions
#ADD https://ext.lucee.org/lucee.admin.extension-1.0.0.5.lex /opt/lucee/server/lucee-server/deploy/
#RUN curl -o /opt/lucee/server/lucee-server/deploy/lucee.admin.extension-1.0.0.5.lex \
#    https://ext.lucee.org/lucee.admin.extension-1.0.0.5.lex
COPY ./extensions/lucee.admin.extension-1.0.0.5.lex /opt/lucee/server/lucee-server/deploy/lucee.admin.extension-1.0.0.5.lex


# Pre-warm Lucee by starting Tomcat
#RUN /bin/bash -c "catalina.sh start"


#ADD https://ext.lucee.org/redis.extension-3.0.0.48.lex /opt/opt/lucee/server/lucee-server/deploy
#RUN curl -o /opt/lucee/server/lucee-server/deploy/redis.extension-3.0.0.48.lex \
#    https://ext.lucee.org/redis.extension-3.0.0.48.lex
COPY ./extensions/redis.extension-3.0.0.48.lex /opt/lucee/server/lucee-server/deploy/redis.extension-3.0.0.48.lex


# ADD https://ext.lucee.org/org.lucee.websocket.extension-1.0.0.11-RC.lex /opt/lucee/server/lucee-server/deploy/
# RUN curl -o /opt/lucee/server/lucee-server/deploy/org.lucee.websocket.extension-1.0.0.11-RC.lex \
#    https://ext.lucee.org/org.lucee.websocket.extension-1.0.0.11-RC.lex

# Quartz Sceduler Extenstion
COPY ./extensions/org.lucee.quartz.extension-1.0.0.27.lex /opt/lucee/server/lucee-server/deploy/org.lucee.quartz.extension-1.0.0.27.lex



# Lucee Config
# - redis cache: quartz
#COPY ./lucee-config.json /opt/lucee/server/lucee-server/context/.CFConfig.json

#RUN /bin/bash -c "sleep 15 && \
#                  catalina.sh stop"

#RUN mkdir -p /opt/lucee/server/lucee-server/context/quartz/
COPY ./quartz-configs/redis-config.quartz  /opt/lucee/server/lucee-server/context/quartz/config.json
# Start Lucee (Tomcat)
CMD ["catalina.sh", "run"]

###
# cat /opt/lucee/server/lucee-server/context/.CFConfig.json