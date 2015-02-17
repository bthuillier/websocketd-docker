FROM base/archlinux:latest
MAINTAINER Benjamin Thuillier <benjaminthuillier@gmail.com>

RUN mkdir /project

ADD . /project

WORKDIR /project

RUN pacman --noconfirm -Sy ca-certificates openssl wget unzip; yes | pacman -Scc

RUN wget -q -O /tmp/websocketd.zip \
    https://github.com/joewalnes/websocketd/releases/download/v0.2.9/websocketd-0.2.9-linux_amd64.zip \
    && unzip /tmp/websocketd.zip -d /tmp/websocketd && mv /tmp/websocketd/websocketd /usr/bin \
    && chmod +x /usr/bin/websocketd

EXPOSE 8080

ENTRYPOINT websocketd --port=8080 --staticdir=. --devconsole count.sh
