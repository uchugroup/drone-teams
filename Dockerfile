FROM golang:1.16-alpine as builder

WORKDIR /go/src/drone-teams
COPY . .

RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -a -tags netgo -o drone-teams ./cmd/drone-teams

FROM alpine:3.13

RUN apk add --no-cache ca-certificates

COPY --from=builder /go/src/drone-teams/drone-teams /bin/
ENTRYPOINT ["/bin/drone-teams"]

