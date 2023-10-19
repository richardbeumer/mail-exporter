###############################################################################
# BUILD STAGE

FROM cgr.dev/chainguard/go:latest-dev AS builder
RUN mkdir /build
ADD src /build/
WORKDIR /build
RUN go mod tidy
RUN go build mailexporter.go

###############################################################################
# PACKAGE STAGE

FROM cgr.dev/chainguard/go:latest
EXPOSE 9225
COPY --from=builder /build/mailexporter /app/
WORKDIR /app
ENTRYPOINT ["./mailexporter"]