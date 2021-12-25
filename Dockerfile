FROM --platform=$BUILDPLATFORM golang:alpine AS builder
ARG UPX_VERSION="3.96"
SHELL ["/bin/sh","-cex"]
ARG TARGETOS TARGETARCH
RUN apk --update add --no-cache curl git; \
  git clone --depth 1 https://github.com/pratikbalar/tarrer.git /src
WORKDIR /src
RUN --mount=type=cache,target=/root/.cache/go-build \
  --mount=target=/go/pkg/mod,type=cache \
  CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH \
    go build -o /usr/local/bin/tarrer -trimpath -ldflags "-s -w"
RUN if [[ ${TARGETARCH} == "386" ]]; then arch="i386";  \
  elif [[ ${TARGETARCH} == "mips64le" ]]; then arch="mipsel";  \
  elif [[ ${TARGETARCH} == "mips64" ]]; then arch="mips";  \
  elif [[ ${TARGETARCH} == "ppc64le" ]]; then arch="powerpc64le";  \
  else arch="${TARGETARCH}"; \
  fi; \
  wget 'https://github.com/upx/upx/releases/download/v'${UPX_VERSION}'/upx-'${UPX_VERSION}'-'${arch}'_'${TARGETOS}'.tar.xz' -O /tmp/upx.tar.xz; \
  tarrer /tmp/upx.tar.xz /tmp/; \
  cp "$(find /tmp/ -name 'upx' -type f)" /tmp/

FROM scratch
WORKDIR /app
COPY --from=builder /tmp/upx /usr/local/bin/upx
ENTRYPOINT ["/usr/local/bin/upx","-9"]

# remain linux/riscv64x,linux/s390x
