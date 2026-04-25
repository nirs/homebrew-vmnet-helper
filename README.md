# homebrew-vmnet-helper

Homebrew formula for vmnet-helper - High-performance network proxy connecting VMs to macOS vmnet

## Installation

```console
brew tap nirs/vmnet-helper
brew install vmnet-helper
```

> [!NOTE]
> This tap requires macOS 26 (Tahoe) or later.
> For macOS 15 and earlier see
> [installation](https://github.com/nirs/vmnet-helper#installation).

## Documentation

See [vmnet-helper](https://github.com/nirs/vmnet-helper) for documentation.

## Development

### Setup

Remove the current tap if installed, then tap from your local clone:

```console
make untap
make tap
```

### Install and test

```console
make install
make test
make audit
```

### After switching branches or making new commits

```console
make sync
```

### Bump to a new release

After tagging a new release in the
[vmnet-helper](https://github.com/nirs/vmnet-helper) repo:

```console
./bump.sh v0.12.0
make install
make test
make audit
```

The bump script downloads the source tarball, computes the SHA256, and
updates the formula URL and hash.
