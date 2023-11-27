ARG GOLANG_VERSION=alpine
ARG ALPINE_VERSION=latest

FROM golang:${GOLANG_VERSION} as builder

LABEL maintainer="Igor097"

WORKDIR /app

COPY go.mod go.sum /
RUN go mod download

COPY . .

RUN CGO_ENABLE=0 GOOS=linux GOARCH=amd64 go build -o gserver main.go

FROM alpine:${ALPINE_VERSION}

WORKDIR /app
COPY --from=builder /app .

EXPOSE 8080

CMD [ "./gserver" ]

