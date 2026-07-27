class Dnsbench < Formula
  desc "Benchmark and diagnose recursive DNS resolvers from your own network"
  homepage "https://github.com/ialexsilva/dnsbench-cli"
  version "0.6.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/ialexsilva/dnsbench-cli/releases/download/v0.6.0/dnsbench-darwin-arm64.tar.gz"
      sha256 "87ad0b01d082f91005349f5bbde83562f817ce4c847f30985b75d1a176fa5825"
    end
    on_intel do
      url "https://github.com/ialexsilva/dnsbench-cli/releases/download/v0.6.0/dnsbench-darwin-amd64.tar.gz"
      sha256 "824473c03d6909df257fd8c8a7cd707e85f0b6d2a988078e0472c2f37f2193fc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ialexsilva/dnsbench-cli/releases/download/v0.6.0/dnsbench-linux-amd64.tar.gz"
      sha256 "1675c64b8cc022957fc61e26e1f1d978f8bca1e3632e235146db9bbb500958ad"
    end
  end

  def install
    bin.install "dnsbench"
  end

  test do
    assert_match "dnsbench version #{version}", shell_output("#{bin}/dnsbench --version")
  end
end
