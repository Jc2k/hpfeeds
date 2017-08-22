FROM alpine:3.6 AS builder
RUN apk --no-cache add py2-pip gcc python-dev musl-dev py-virtualenv
RUN virtualenv /app
RUN /app/bin/pip install gevent


FROM alpine:3.6

RUN apk --no-cache add sqlite python

COPY --from=builder /app /app

COPY broker /app/src

COPY docker/docker_entrypoint.sh /
COPY docker/initial.sql /app/src/initial.sql

RUN mkdir /app/var
WORKDIR /app/var
VOLUME /app/var

EXPOSE 20000

CMD ["/docker_entrypoint.sh"]
