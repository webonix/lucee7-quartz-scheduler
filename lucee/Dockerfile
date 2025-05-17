ARG LUCEE_VERSION
ARG LUCEE_ADMIN_PASSWORD

# Use the lightweight Lucee 6.2 image
FROM lucee/lucee:${LUCEE_VERSION}
# FROM lucee/lucee:6.2.1.4-SNAPSHOT
# FROM lucee/lucee:6.2-light

# Set environment variables (optional)
ENV LUCEE_ADMIN_PASSWORD=${LUCEE_ADMIN_PASSWORD}
ENV LUCEE_JAVA_OPTS="-Xms256m -Xmx512m"



# Install vi
RUN apt-get update && apt-get install -y vim && apt-get clean


# Lucee Config
COPY ./config/lucee-config-quartz-redis-mysql.json /opt/lucee/server/lucee-server/context/.CFConfig.json


### Extenstion ###

  COPY ./extensions/quartz-extension-1.0.0.34-BETA.lex /opt/lucee/server/lucee-server/deploy/
  #ADD https://ext.lucee.org/quartz-extension-1.0.0.34-BETA.lex /opt/lucee/server/lucee-server/deploy/

  #ADD https://ext.lucee.org/lucee.admin.extension-1.0.0.5.lex /opt/lucee/server/lucee-server/deploy/
  #COPY ./extensions/lucee.admin.extension-1.0.0.5.lex /opt/lucee/server/lucee-server/deploy/lucee.admin.extension-1.0.0.5.lex

  #ADD https://ext.lucee.org/redis.extension-3.0.0.48.lex /opt/lucee/server/lucee-server/deploy/
  COPY ./extensions/redis.extension-3.0.0.48.lex /opt/lucee/server/lucee-server/deploy/redis.extension-3.0.0.48.lex

  # ADD https://ext.lucee.org/org.lucee.websocket.extension-1.0.0.11-RC.lex /opt/lucee/server/lucee-server/deploy/
  # RUN curl -o /opt/lucee/server/lucee-server/deploy/org.lucee.websocket.extension-1.0.0.11-RC.lex \
  #    https://ext.lucee.org/org.lucee.websocket.extension-1.0.0.11-RC.lex

  # mySQL jdbc
  #ADD https://ext.lucee.org/com.mysql.cj-9.2.0.lex /opt/lucee/server/lucee-server/deploy/
  COPY ./extensions/com.mysql.cj-9.2.0.lex /opt/lucee/server/lucee-server/deploy/com.mysql.cj-9.2.0.lex


# Quartz Scheduler Config - for mySQL
  COPY ./quartz-configs/mysql-config-2.quartz  /opt/lucee/server/lucee-server/context/quartz/config.json
# COPY ./quartz-configs/mysql-config-2.quartz  /opt/lucee/server/lucee-server/deploy/config.quartz


# Start Lucee (Tomcat)
CMD ["catalina.sh", "run"]