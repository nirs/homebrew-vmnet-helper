# SPDX-FileCopyrightText: The vmnet-helper authors
# SPDX-License-Identifier: Apache-2.0

class VmnetHelper < Formula
  desc "High-performance network proxy connecting VMs to macOS vmnet"
  homepage "https://github.com/nirs/vmnet-helper"
  url "https://github.com/nirs/vmnet-helper/archive/refs/tags/v0.12.0-pre4.tar.gz"
  sha256 "be68b95fae43f556d6c8fe8345a4bb78def1792d7f9e835534eb55d3c27ef0d7"
  license "Apache-2.0"
  head "https://github.com/nirs/vmnet-helper.git", branch: "main"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on macos: :tahoe

  def install
    system "meson", "setup", "build", *std_meson_args, "--bindir=#{libexec}"
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
    system "codesign", "--force", "--sign", "-",
           "--entitlements", "building/entitlements.plist",
           libexec/"vmnet-helper"
  end

  test do
    output = shell_output("#{libexec}/vmnet-helper --version")
    assert_match "v#{version}", output
    output = shell_output("codesign -d --entitlements - #{libexec}/vmnet-helper")
    assert_match "com.apple.security.virtualization", output
  end
end
