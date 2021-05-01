FROM golang:1.16-alpine as builder

WORKDIR /build

COPY main.go .
COPY go.mod .

RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o main

WORKDIR /dist
RUN cp /build/main .

FROM scratch
COPY --from=builder /dist/main /

ENTRYPOINT ["/main"]