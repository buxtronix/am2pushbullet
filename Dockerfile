FROM golang AS builder
WORKDIR /go/src/app
COPY am2pushbullet.go .
ENV CGO_ENABLED=0
RUN go mod init && go get -v && go mod download && go build -o /go/bin/am2pushbullet .

FROM alpine
COPY entrypoint.sh /
COPY --from=builder /go/bin/am2pushbullet /
ENTRYPOINT [ "/entrypoint.sh" ]
