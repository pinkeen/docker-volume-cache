FROM alpine:latest

RUN apk --no-cache add \
        unison \
        sudo \
        findmnt \
    && adduser -D -h /dvs dvs \
    && echo 'ALL ALL = (ALL) NOPASSWD:ALL' > /etc/sudoers

COPY entrypoint /usr/bin/dvs

USER dvs
WORKDIR "/dvs"
VOLUME [ "/dvs/cache" ]
ENTRYPOINT [ "/usr/bin/dvs" ]