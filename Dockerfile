FROM golang:1.16 as builder

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 go build -o mc-monitor

FROM scratch
COPY --from=builder /build/mc-monitor /mc-monitor
ENTRYPOINT ["/mc-monitor"]
