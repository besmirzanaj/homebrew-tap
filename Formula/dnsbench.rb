class Dnsbench < Formula
  desc "Benchmark and diagnose recursive DNS resolvers from your own network"
  homepage "https://github.com/ialexsilva/dnsbench-cli"
  version "0.7.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/ialexsilva/dnsbench-cli/releases/download/v0.7.1/dnsbench-darwin-arm64.tar.gz"
      sha256 "40ee3525010014179d3849b58ee8335e2e87f0dd811fb2df583386347a3d2cb4"
    end
    on_intel do
      url "https://github.com/ialexsilva/dnsbench-cli/releases/download/v0.7.1/dnsbench-darwin-amd64.tar.gz"
      sha256 "9e0a3d9572e452b10d1f5aaaf8d9935aa2537039a8dfc50768de7bb0eb9f7292"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ialexsilva/dnsbench-cli/releases/download/v0.7.1/dnsbench-linux-amd64.tar.gz"
      sha256 "f8b02acc18eb9747bd4d16b3056769f3f03e56a6c2a86ed47074e81c11d2acdb"
    end
  end

  def install
    bin.install "dnsbench"
  end

  test do
    assert_match "dnsbench version #{version}", shell_output("#{bin}/dnsbench --version")
  end
end
