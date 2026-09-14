class Dnsbench < Formula
  desc "Benchmark and diagnose recursive DNS resolvers from your own network"
  homepage "https://github.com/ialexsilva/dnsbench-cli"
  version "0.8.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/ialexsilva/dnsbench-cli/releases/download/v0.8.0/dnsbench-darwin-arm64.tar.gz"
      sha256 "78e42aaa97e6d736fa4f6d4fac0a047ca3bd41b92aa5d60eab9f7976fd989066"
    end
    on_intel do
      url "https://github.com/ialexsilva/dnsbench-cli/releases/download/v0.8.0/dnsbench-darwin-amd64.tar.gz"
      sha256 "aa2009b86a3b43e9516f8b9fc929d0e600bfca8bdf40b68f2958e809b1bc93b8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ialexsilva/dnsbench-cli/releases/download/v0.8.0/dnsbench-linux-amd64.tar.gz"
      sha256 "3f9992151702353ae4af1fa78821ff73dc99ca2756a4598c8f775bcf50c1ce57"
    end
  end

  def install
    bin.install "dnsbench"
  end

  test do
    assert_match "dnsbench version #{version}", shell_output("#{bin}/dnsbench --version")
  end
end
