#!/bin/sh
# SPDX-FileCopyrightText: The vmnet-helper authors
# SPDX-License-Identifier: Apache-2.0

# Update the formula to a new release version.

set -eo pipefail

if [ -z "$1" ]; then
    echo "Usage: $0 VERSION"
    echo "Example: $0 v0.12.0-pre4"
    exit 1
fi

version=$1
formula=Formula/vmnet-helper.rb
url="https://github.com/nirs/vmnet-helper/archive/refs/tags/${version}.tar.gz"

echo "Downloading ${url} ..."
sha=$(curl -fsSL "$url" | shasum -a 256 | cut -d' ' -f1)

sed -i '' "s|archive/refs/tags/.*\.tar\.gz|archive/refs/tags/${version}.tar.gz|" "$formula"
sed -i '' "s|sha256 \".*\"|sha256 \"${sha}\"|" "$formula"

echo "Updated ${formula} to ${version} (${sha})"
