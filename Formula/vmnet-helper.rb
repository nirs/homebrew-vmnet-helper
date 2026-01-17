# SPDX-FileCopyrightText: The vmnet-helper authors
# SPDX-License-Identifier: Apache-2.0

class VmnetHelper < Formula
  desc "High-performance network proxy connecting VMs to macOS vmnet"
  homepage "https://github.com/nirs/vmnet-helper"
  url "https://github.com/nirs/vmnet-helper/releases/download/v0.9.0/vmnet-helper.tar.gz"
  sha256 "5c76413428a09ce45faf719f7fb2f621e9b3a0b103024837aecdb8319cdcf32c"
  license "Apache-2.0"

  depends_on :macos => :tahoe

  def install
    bin.install "opt/vmnet-helper/bin/vmnet-helper"
    bin.install "opt/vmnet-helper/bin/vmnet-client"
  end

  test do
    output = shell_output("#{bin}/vmnet-helper --version")
    assert_match "v0.9.0", output
    assert_match "b76a29eb542d3ce4df18c4ebef6b1498174a02e5", output
  end
end
