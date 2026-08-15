# Install benchmark

## Overview

On a clean Mac, `brew install vmnet-helper` is about **20× faster** from
a bottle than from source: **~2s** vs **~33s** on Apple silicon, **~3s**
vs **~56s** on Intel. Most source time is pouring Python and `meson
install`. Compiling is only **~4s** on Apple silicon (**~12%**).

## Source vs bottle

| Job                   | Run 1 | Run 2 | Run 3 |      Mean |  Speedup |
|-----------------------|------:|------:|------:|----------:|---------:|
| macos-26-bottle       |  2.5s |  1.2s |  1.2s |  **1.6s** |        — |
| macos-26-source       | 31.1s | 33.6s | 33.2s | **32.6s** | **~20×** |
| macos-26-intel-bottle |  4.3s |  2.3s |  2.8s |  **3.1s** |        — |
| macos-26-intel-source | 46.2s | 61.2s | 61.8s | **56.4s** | **~18×** |

Times are `time` real for `brew install` only . Three runs on GitHub-hosted
`macos-26` and `macos-26-intel` ([31899887517](https://github.com/nirs/homebrew-vmnet-helper/actions/runs/31899887517)).

## Time spent in source install

Mean of the three source runs, largest step first:

| Step             | Apple silicon |    Intel |
|------------------|--------------:|---------:|
| pour python@3.14 |          ~14s |     ~25s |
| meson install    |           ~6s |     ~11s |
| meson compile    |           ~4s |      ~8s |
| fetch downloads  |           ~4s |      ~7s |
| meson setup      |           ~4s |      ~5s |
| pour meson       |           <1s |      <1s |
| **Total**        |      **~33s** | **~56s** |

`fetch downloads` is Homebrew starting and downloading the formula
tarball and dependency bottles. `pour python@3.14` and `pour meson`
install those formulae from bottles. `meson setup`, `meson compile`, and
`meson install` build vmnet-helper.

## How this was tested

Author laptop already has Python and meson, so it cannot show a clean-machine
source install. GitHub Actions macOS images do not have those formulae (ninja
was already present). Runner times are noisy, but this is the only practical
way to measure a clean-machine install.

The workflow is [`.github/workflows/bench.yaml`](../.github/workflows/bench.yaml).
It does not run on ordinary formula PRs. Each job taps `nirs/vmnet-helper` from
GitHub, the same as a user, then runs either `--force-bottle` (fail if no
bottle, never compile) or `--build-from-source`. `--yes` skips prompts.

## How to re-run

In GitHub Actions, open **bench** and use **Run workflow**. Use `main`
or any branch; the job installs from the published tap, not from the
workflow ref.