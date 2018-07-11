FROM debian:jessie
MAINTAINER Ted Papaioannou <tap792@gmail.com>

RUN apt-get update && \
apt-get install --no-install-recommends -y \
unzip \
ca-certificates \
wget && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /
ADD https://github.com/gophish/gophish/releases/download/v0.6.0/gophish-v0.6.0-linux-64bit.zip /tmp
RUN unzip /tmp/gophish-v0.6.0-linux-64bit.zip -d /tmp/gophish-v0.6.0 && mv /tmp/gophish-v0.6.0 /app && rm /tmp/gophish-v0.6.0-linux-64bit.zip
WORKDIR /app
RUN sed -i "s|127.0.0.1|0.0.0.0|g" config.json
RUN sed -i "s|gophish.db|database/gophish.db|g" config.json
RUN chmod +x ./gophish

VOLUME ["/app/database"]

EXPOSE 3333 80
ENTRYPOINT ["./gophish"]
