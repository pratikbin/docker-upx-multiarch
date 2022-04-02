# docker-upx-multiarch

UPX container image with multi plateform support

supported plateforms

- linux/amd64
- linux/arm64
- linux/arm/v6
- linux/arm/v7
- linux/386
- linux/mips64le
- linux/mips64
- linux/ppc64le

## Usage

```docker run --rm -it -v $(pwd):/app/ pratikimprowise/upx app```

or within dockerfile

- Simply

  ```dockerfile
  FROM ubuntu
  COPY --from=pratikimprowise/upx / /
  RUN upx -9 xxx
  ```

- Using buildx

  ```dockerfile
  FROM --platform=$BUILDPLATFORM pratikimprowise/upx AS upx
  FROM --platform=$BUILDPLATFORM ubuntu
  COPY --from=upx / /
  RUN upx -9 xxx
  ```

## Projects that are using this

- [tarrer](https://github.com/pratikbalar/tarrer/blob/0dfe28028ea20ff6fb0255fa10262adca62d0b23/Dockerfile#L43)

> **NOTE**: xz utils was not available for all architecture so created [pratikbalar/tarrer](https://github.com/pratikbalar/tarrer) dumb utility in golang that can extract `br`, `bz2`, `zip`, `gz`, `lz4`, `sz`, `xz`, `zstd` archives.
> > thanks to [mholt/archiver](https://github.com/mholt/archiver)

---

**May the Source Be With You**
