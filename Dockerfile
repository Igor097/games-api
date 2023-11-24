ARG GOLANG_VERSION=1.21

FROM golang:${GOLANG_VERSION} as builder

LABEL maintainer="Igor097"

WORKDIR /app
COPY . ./

RUN go mod download && \
    CGO_ENABLE=0 GOOS=linux GOARCH=amd64 go build -o gserver main.go

EXPOSE 8080

CMD [ "./gserver" ]

