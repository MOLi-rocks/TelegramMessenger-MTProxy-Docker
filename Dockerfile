FROM ubuntu:20.04 as compiler
WORKDIR /
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    libssl-dev \
    zlib1g-dev \
 && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/TelegramMessenger/MTProxy
WORKDIR /MTProxy
RUN make

FROM ubuntu:20.04
RUN apt-get update && apt-get install -y \
    curl \
    cron \
    xxd \
    openssl \
 && rm -rf /var/lib/apt/lists/*
COPY --from=compiler /MTProxy/objs/bin/mtproto-proxy /usr/bin/mtproto-proxy
RUN mkdir /mtproto-proxy-config
COPY ./mtproxy-config-updater.sh /mtproto-proxy-config/mtproxy-config-updater.sh
RUN chmod +x /mtproto-proxy-config/mtproxy-config-updater.sh
RUN { echo "59	23	*	*	*	/mtproto-proxy-config/mtproxy-config-updater.sh"; } | crontab -
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 443 8888
