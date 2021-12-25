ARG UPX_VERSION="3.96"
FROM --platform=$BUILDPLATFORM alpine:latest AS builder
SHELL ["/bin/sh","-cex"]
ARG TARGETOS TARGETARCH
RUN set -ex; \
  if [[ ${TARGETARCH} == "386" ]]; then arch="i386";  \
  elif [[ ${TARGETARCH} == "mips64le" ]]; then arch="mipsel";  \
  elif [[ ${TARGETARCH} == "mips64" ]]; then arch="mips";  \
  elif [[ ${TARGETARCH} == "ppc64le" ]]; then arch="powerpc64le";  \
  else arch="${TARGETARCH}"; \
  fi; \
  wget -O /bin/tarrer 'https://github.com/pratikbalar/tarrer/releases/download/v0.0.1/tarrer_0.0.1_'${TARGETOS}'_'${TARGETARCH}; \
  chmod +X /bin/tarrer; \
  wget 'https://github.com/upx/upx/releases/download/v'${UPX_VERSION}'/upx-'${UPX_VERSION}'-'${arch}'_'${TARGETOS}'.tar.xz' -O /tmp/upx.tar.xz; \
  tarrer /tmp/upx.tar.xz /tmp/; \
  cp "$(find /tmp/ -name 'upx' -type f)" /tmp/

FROM scratch
WORKDIR /app
COPY --from=builder /tmp/upx /usr/local/bin/upx
ENTRYPOINT ["/usr/local/bin/upx","-9"]

# remain linux/riscv64x,linux/s390x
