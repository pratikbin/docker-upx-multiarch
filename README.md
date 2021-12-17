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

```docker run --rm -it -v $(pwd):/app/ pratikbalar/upx app```


> **NOTE**: xz utils was not available for all architecture in alpine so created [pratikbalar/tarrer](https://github.com/pratikbalar/tarrer) utility (size around `4MB`) in golang that can extract `br`, `bz2`, `zip`, `gz`, `lz4`, `sz`, `xz`, `zstd` archives.
> > thanks to [mholt/archiver](https://github.com/mholt/archiver)

---

**May the Source Be With You**
