FROM debian:jessie
MAINTAINER Matteo Guglielmetti <matteo.guglielmetti@hotmail.it>

RUN apt-get update && \
apt-get install --no-install-recommends -y \
unzip \
ca-certificates \
wget && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /
ADD https://github.com/gophish/gophish/releases/download/v$RELEASE/gophish_linux_64bit.zip /tmp/
RUN unzip /tmp/gophish_linux_64bit.zip && mv /gophish_linux_64bit /app && rm /tmp/gophish_linux_64bit.zip
WORKDIR /app
RUN sed -i "s|127.0.0.1|0.0.0.0|g" config.json
RUN sed -i "s|gophish.db|database/gophish.db|g" config.json
RUN chmod +x ./gophish

VOLUME ["/app/database"]

EXPOSE 3333 80
ENTRYPOINT ["./gophish"]
