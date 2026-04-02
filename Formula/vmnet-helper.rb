# SPDX-FileCopyrightText: The vmnet-helper authors
# SPDX-License-Identifier: Apache-2.0

class VmnetHelper < Formula
  desc "High-performance network proxy connecting VMs to macOS vmnet"
  homepage "https://github.com/nirs/vmnet-helper"
  url "https://github.com/nirs/vmnet-helper/releases/download/v0.11.0/vmnet-helper.tar.gz"
  sha256 "dfeca3e8cc9d9b1e0e40df12e42975f10433b9ccbb8f0a239d42df99611caa76"
  license "Apache-2.0"

  depends_on :macos => :tahoe

  def install
    libexec.install "vmnet-helper/bin/vmnet-helper"
    libexec.install "vmnet-helper/bin/vmnet-run"
    rm_f libexec/"vmnet-client"
  end

  test do
    output = shell_output("#{libexec}/vmnet-helper --version")
    assert_match "v0.11.0", output
    assert_match "3164bb571e132022a9c35621b3e3bb1db5fb8a3b", output
  end
end
