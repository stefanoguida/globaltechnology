FROM alpine:latest

COPY ./cron.sh /etc/periodic/hourly

RUN touch /var/log/cron.log && chmod 777 /var/log/cron.log

RUN apk update && \
    apk upgrade && \
    apk add --no-cache mariadb-client && \
    chmod a+x /etc/periodic/hourly/*
