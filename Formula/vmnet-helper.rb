# SPDX-FileCopyrightText: The vmnet-helper authors
# SPDX-License-Identifier: Apache-2.0

class VmnetHelper < Formula
  desc "High-performance network proxy connecting VMs to macOS vmnet"
  homepage "https://github.com/nirs/vmnet-helper"
  url "https://github.com/nirs/vmnet-helper/releases/download/v0.10.0/vmnet-helper.tar.gz"
  sha256 "bcf37a2631878a24fd02e2bf812b7387d4c4ff0bcee27c3f4be410c040896f8b"
  license "Apache-2.0"

  depends_on :macos => :tahoe

  def install
    libexec.install "vmnet-helper/bin/vmnet-helper"
    libexec.install "vmnet-helper/bin/vmnet-client"
  end

  test do
    output = shell_output("#{libexec}/vmnet-helper --version")
    assert_match "v0.10.0", output
    assert_match "c593b89a2e93e92cfe7c5b1189e1eeb2c7977554", output
  end
end
