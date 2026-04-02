# SPDX-FileCopyrightText: The vmnet-helper authors
# SPDX-License-Identifier: Apache-2.0

class VmnetHelper < Formula
  desc "High-performance network proxy connecting VMs to macOS vmnet"
  homepage "https://github.com/nirs/vmnet-helper"
  url "https://github.com/nirs/vmnet-helper/releases/download/v0.11.0/vmnet-helper.tar.gz"
  sha256 "791270bd91801cac88490ff19c0b68016bedb5d290d79f9fa0cd4aab940be03a"
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
