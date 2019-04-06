FROM alpine:latest

MAINTAINER chuixifeng <chuixifeng@gmail.com>

RUN apk update \
        && apk add --no-cache --update aria2 nginx \
        && mkdir -p aria2/conf aria2/conf-temp data/download aria-ng  /run/nginx \
        && wget --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/1.0.1/AriaNg-1.0.1.zip \
        && wget --no-check-certificate https://github.com/filebrowser/filebrowser/releases/download/v2.0.3/linux-amd64-filebrowser.tar.gz \
        && unzip AriaNg-1.0.1.zip -d aria-ng \
        && tar -zxvf linux-amd64-filebrowser.tar.gz    \
        && rm -rf AriaNg-1.0.1.zip \
        && rm -rf linux-amd64-filebrowser.tar.gz

COPY init.sh /aria2/init.sh
COPY conf-temp /aria2/conf-temp
COPY default.conf /etc/nginx/conf.d
COPY passwd.db /etc/nginx/


WORKDIR /
EXPOSE 6800 81 82

CMD ["/aria2/init.sh"]
