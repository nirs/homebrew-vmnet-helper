# homebrew-vmnet-helper

Homebrew formula for vmnet-helper - High-performance network proxy connecting VMs to macOS vmnet

## Installation

```console
brew tap nirs/vmnet-helper
brew trust nirs/vmnet-helper
brew install vmnet-helper
```

> [!NOTE]
> This tap requires macOS 26 (Tahoe) or later.
> For macOS 15 and earlier see
> [installation](https://github.com/nirs/vmnet-helper#installation).

## Documentation

See [vmnet-helper](https://github.com/nirs/vmnet-helper) for documentation.

## Bump to a new release

After tagging a new release in the
[vmnet-helper](https://github.com/nirs/vmnet-helper) repo:

1. Run `./bump v0.14.0` to update the formula URL and SHA256.
2. Push a PR with the updated formula.
3. Wait for CI to pass (bottles built and tested on macOS 26 intel and arm64).
4. Label the PR `pr-pull`. CI uploads bottles to ghcr.io and pushes a
   `bottle do` commit to the PR branch. `brew install` still uses the
   formula on `main`.
5. Merge the PR. Users then get the new formula and bottles.

For local testing before merging, see [Local development](#local-development).

## Local development

CI builds and tests bottles automatically. Local testing is optional but
useful when iterating on formula changes.

### Build and test a bottle locally

```console
brew install --build-bottle vmnet-helper
brew bottle vmnet-helper
brew reinstall ./vmnet-helper--*.bottle.tar.gz
brew test vmnet-helper
```

1. Build from source in a way suitable for bottling (no local path references).
2. Package the build into a bottle `.tar.gz` file.
3. Install from the bottle to verify it works as a pre-built binary.
4. Run the formula's test block to verify the binary and codesigning.
