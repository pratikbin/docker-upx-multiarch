FROM --platform=$BUILDPLATFORM alpine:latest AS builder
ARG UPX_VERSION="3.96"
SHELL ["/bin/sh","-cex"]
ARG TARGETOS TARGETARCH
RUN set -ex; \
  if [[ ${TARGETARCH} == "386" ]]; then arch="i386";  \
  elif [[ ${TARGETARCH} == "mips64le" ]]; then arch="mipsel";  \
  elif [[ ${TARGETARCH} == "mips64" ]]; then arch="mips";  \
  elif [[ ${TARGETARCH} == "ppc64le" ]]; then arch="powerpc64le";  \
  else arch="${TARGETARCH}"; \
  fi; \
  wget -O /bin/tarrer 'https://github.com/pratikbalar/tarrer/releases/download/v0.0.1-rc0/tarrer_0.0.1-rc0_'${TARGETOS}'_'${TARGETARCH}; \
  chmod +x /bin/tarrer; \
  wget -O /tmp/upx.tar.xz 'https://github.com/upx/upx/releases/download/v'${UPX_VERSION}'/upx-'${UPX_VERSION}'-'${arch}'_'${TARGETOS}'.tar.xz'; \
  tarrer /tmp/upx.tar.xz /tmp/; \
  cp "$(find /tmp/ -name 'upx' -type f)" /tmp/

FROM scratch
WORKDIR /app
COPY --from=builder /tmp/upx /usr/local/bin/upx
ENTRYPOINT ["/usr/local/bin/upx","-9"]

# remain linux/riscv64x,linux/s390x
