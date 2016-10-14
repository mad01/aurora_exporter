FROM alpine:3.4

EXPOSE 9113

RUN addgroup exporter \
 && adduser -S -G exporter exporter

COPY . /go/src/github.com/tommyulfsparre/aurora_exporter

RUN apk --update add ca-certificates \
 && apk --update add --virtual build-deps go git \
 && cd /go/src/github.com/tommyulfsparre/aurora_exporter \
 && GOPATH=/go go get \
 && GOPATH=/go go build -o /bin/aurora-exporter \
 && apk del --purge build-deps \
 && rm -rf /go/bin /go/pkg /var/cache/apk/*

USER exporter

ENTRYPOINT [ "/bin/aurora-exporter" ]
