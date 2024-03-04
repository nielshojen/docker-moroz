FROM alpine:3.6

ENV MOROZ_VERSION=2.0.1

COPY run.sh /run.sh

RUN apk --no-cache add curl ca-certificates
RUN curl -L https://github.com/groob/moroz/releases/download/${MOROZ_VERSION}/moroz_${MOROZ_VERSION}.zip -o /moroz.zip
RUN unzip /moroz.zip
RUN mv /build/linux/moroz /usr/bin/moroz
RUN rm -r /build
RUN rm -r /moroz.zip
RUN chmod a+x /usr/bin/moroz
RUN apk del curl
RUN chmod a+x /run.sh

VOLUME ["/configs","/certs","/logs"]

EXPOSE 8080

CMD ["/run.sh"]
