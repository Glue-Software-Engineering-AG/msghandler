FROM amazoncorretto:8u402-alpine3.19-jre

LABEL org.opencontainers.image.authors="Glue Software Engineering AG <support@fenceit.ch>"

# Installation dir of msghandler
ARG MSGHANDLER_INSTALL_DIR="/opt/msghandler"

# set correct Timezone
ENV TZ Europe/Zurich

# Expose default msghandler webservice port
EXPOSE 18080

COPY apps/open-egov-msghandler-*-linux-x86-64.tar.gz $MSGHANDLER_INSTALL_DIR/

RUN \
    # Install additional packages \
    apk update && apk add --no-cache --upgrade \
    bash \
    gcompat \
    tzdata && \
    # Create installation directory \
    mkdir -p "$MSGHANDLER_INSTALL_DIR" && \
    cd  "$MSGHANDLER_INSTALL_DIR" && \
    # extract distro \
    tar -zxvf open-egov-msghandler-*-linux-x86-64.tar.gz && \
    # clean up \
    rm open-egov-msghandler-*-linux-x86-64.tar.gz  && \
    # create symbolic link 'current'
    ln -s open-egov-msghandler-* current  && \
    # remove example config file. We will use the config file mounted from host \
    rm /opt/msghandler/current/conf/config.xml && \
    # Adapt permissions such, that MH can be started using any user \
    cd "$MSGHANDLER_INSTALL_DIR"/current && \
    # all files: (644) rw r r \
    find . -type f -exec chmod 0644 {} \; && \
    # all dirs: (755) rwx rx rx \
    find . -type d -exec chmod 0755 {} \; && \
    # Create all needed dirs under /app/msghandler (see Glue-Software-Engineering-AG/msghandler-docker#5) \
    mkdir -p \
      /working/tmp/receiving \
      /working/tmp/preparing \
      /working/tmp \
      /working/unknown \
      /working/corrupted \
      /working/db \
      /working/sent \
      /app/msghandler/inbox \
      /app/msghandler/outbox \; && \
    # the following files must be executable\
    chmod 0755 /opt/msghandler/current/bin/message-handler \
             /opt/msghandler/current/bin/wrapper \
             /opt/msghandler/current/lib/native/libwrapper.so && \
    # the bin directory must be writeable be anyone. The pid file WILL be written to it \
    chmod 0777 /opt/msghandler/current/bin

WORKDIR $MSGHANDLER_INSTALL_DIR/current

# Start MH
ENTRYPOINT ["./bin/message-handler","docker-console"]
