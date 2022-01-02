FROM golang:1.17 AS builder
WORKDIR /go
RUN apt update -y && apt install upx -y
COPY hello-world.go .
RUN go build hello-world.go
RUN upx --brute hello-world

# Stage 2 - Compact and deliver to production

FROM gcr.io/distroless/static
WORKDIR /go
COPY --from=builder /go/hello-world .
ENTRYPOINT ["./hello-world"]