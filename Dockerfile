FROM --platform=$BUILDPLATFORM golang:latest as builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . ./

RUN export "GOOS=$(echo "$TARGETPLATFORM" | cut -d/ -f1)"; \
    export "GOARCH=$(echo "$TARGETPLATFORM" | cut -d/ -f2)"; \
    export CGO_ENABLED=0; \
    go build -o ./backend main.go

FROM --platform=$TARGETPLATFORM scratch

COPY --from=builder /app/backend /app/backend
CMD ["/app/backend"]
