FROM esycat/java:oracle-8

MAINTAINER "Damir Garifullin" <gosugdr@gmail.com>

ENV UPSOURCE_BUILD 2.0.3653
ENV UPSOURCE_PORT 8080
ENV UPSOURCE_USER upsource
ENV UPSOURCE_SUFFIX upsource

ENV UPSOURCE_DISTFILE upsource-${UPSOURCE_BUILD}.zip
ENV UPSOURCE_PREFIX /opt
ENV UPSOURCE_DIR $UPSOURCE_PREFIX/$UPSOURCE_SUFFIX
ENV UPSOURCE_HOME /var/lib/$UPSOURCE_SUFFIX

WORKDIR $UPSOURCE_PREFIX
ADD https://download.jetbrains.com/upsource/$UPSOURCE_DISTFILE $UPSOURCE_PREFIX/
# COPY $UPSOURCE_DISTFILE $UPSOURCE_PREFIX/
RUN unzip $UPSOURCE_DISTFILE && \
    rm $UPSOURCE_DISTFILE && \
    mv Upsource $UPSOURCE_SUFFIX && \
    mkdir $UPSOURCE_HOME

WORKDIR $UPSOURCE_DIR
RUN bin/upsource.sh configure \
    --backups-dir $UPSOURCE_HOME/backups \
    --data-dir    $UPSOURCE_HOME/data \
    --logs-dir    $UPSOURCE_HOME/log \
    --temp-dir    $UPSOURCE_HOME/tmp \
    --listen-port $UPSOURCE_PORT \
    --base-url    http://localhost:$UPSOURCE_PORT/

ENTRYPOINT ["bin/upsource.sh"]
CMD ["run"]

EXPOSE $UPSOURCE_PORT
VOLUME ["$UPSOURCE_HOME"]
