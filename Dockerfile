FROM alpine:latest

RUN apk --no-cache add unison
COPY entrypoint /usr/bin/dvs

USER root
WORKDIR "/dvs"
VOLUME [ "/var/cache/dvs" ]
ENTRYPOINT [ "/usr/bin/dvs" ]