FROM alpine:latest
LABEL authors "jasperhale <ljy087621@gmail.com>"

ENV VERSION="20200818.0"

RUN set -xe && \
    apk add --no-cache iptables ip6tables  curl && \
    curl -fsSLO --compressed "https://github.com/wangyu-/udp2raw-tunnel/releases/download/$VERSION/udp2raw_binaries.tar.gz" && \
    tar -zxvf udp2raw_binaries.tar.gz && \
    cp udp2raw_amd64 usr/udp2raw && \
    rm udp2raw_* && \
    mv /usr/udp2raw / &&\
    apk del curl 

COPY server.conf /config.conf 
EXPOSE 900

CMD ./udp2raw --conf-file config.conf