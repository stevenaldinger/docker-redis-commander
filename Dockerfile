FROM mhart/alpine-node:base-8

COPY tmp/redis-commander /src/redis-commander

COPY config /config

RUN adduser -S redis-commander \
 && mv /config/entrypoint.sh /usr/bin/entrypoint \
 && mv /config/redis-commander.json /home/redis-commander/.redis-commander \
 && chown -R redis-commander /home/redis-commander

USER redis-commander

ENTRYPOINT entrypoint

EXPOSE 8081
