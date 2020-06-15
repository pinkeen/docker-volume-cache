FROM alpine:latest

RUN apk --no-cache add \
        unison \
        sudo \
        findmnt \
        rsync \
    && mkdir -p /dvs \
    && chmod ugo+rwx /dvs

COPY entrypoint /usr/bin/dvs

USER root
WORKDIR "/dvs"
VOLUME [ "/dvs/cache" ]
ENTRYPOINT [ "/usr/bin/dvs" ]
