# SPDX-FileCopyrightText: The vmnet-helper authors
# SPDX-License-Identifier: Apache-2.0

# First version using bottles.

class VmnetHelper < Formula
  desc "High-performance network proxy connecting VMs to macOS vmnet"
  homepage "https://github.com/nirs/vmnet-helper"
  url "https://github.com/nirs/vmnet-helper/archive/refs/tags/v0.13.0.tar.gz"
  sha256 "69e3818b1fc55e30afd9b8f7429c81a71c13ba40674561225b2ab0694bc44a09"
  license "Apache-2.0"
  head "https://github.com/nirs/vmnet-helper.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/nirs/vmnet-helper"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f4d489697078cbb1ef193dd08aa875bbfacdc74376644ac434a1a0d5944ce8b5"
    sha256 cellar: :any_skip_relocation, tahoe:       "7245e424c54f231471906f0566b92a373cf6cfce1cc483ec5ba47513e62f1f08"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on macos: :tahoe

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
    system "codesign", "--force", "--sign", "-",
           "--entitlements", "building/entitlements.plist",
           bin/"vmnet-helper"
  end

  test do
    output = shell_output("#{bin}/vmnet-helper --version")
    assert_match "v#{version}", output
    output = shell_output("codesign -d --entitlements - #{bin}/vmnet-helper")
    assert_match "com.apple.security.virtualization", output
  end
end
