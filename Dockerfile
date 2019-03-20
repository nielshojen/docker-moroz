FROM alpine:3.6

ENV MOROZ_VERSION=1.0.1

COPY run.sh /run.sh

RUN apk --no-cache add curl ca-certificates && \
    curl -L https://github.com/groob/moroz/releases/download/${MOROZ_VERSION}/moroz-${MOROZ_VERSION}.zip -o /moroz.zip && \
    unzip /moroz.zip && \
    mv /build/moroz-linux-amd64 /usr/bin/moroz && \
    rm -r /build && \
    rm -r /moroz.zip && \
    chmod a+x /usr/bin/moroz && \
    apk del curl && \
    chmod a+x /run.sh

EXPOSE 8080

CMD ["/run.sh"]
