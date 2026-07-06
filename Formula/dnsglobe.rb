class Dnsglobe < Formula
  desc "Global DNS propagation checker TUI — watch a DNS record propagate across 39 public resolvers worldwide, on a world map in your terminal"
  homepage "https://github.com/besmirzanaj/dnsglobe"
  version "0.2.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.2.6/dnsglobe-aarch64-apple-darwin.tar.gz"
      sha256 "c77d321c6e7ffa0ce2b119fdbd833bbdcd9633002c9a3ea49608a36018f5b0e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.2.6/dnsglobe-x86_64-apple-darwin.tar.gz"
      sha256 "1566815f254e4ea77faac7d320616b182a86ddf26922b640d5328b6032c4e19b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.2.6/dnsglobe-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "228578b7ca59830c9a4c5c6114e51c9dd67f50ca68250694df79a239eaca7677"
    end
    if Hardware::CPU.intel?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.2.6/dnsglobe-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "da5a2482080147d88b125b2baec718f29d03bb1192153ac13268cb7b2a444dc1"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "dnsglobe" if OS.mac? && Hardware::CPU.arm?
    bin.install "dnsglobe" if OS.mac? && Hardware::CPU.intel?
    bin.install "dnsglobe" if OS.linux? && Hardware::CPU.arm?
    bin.install "dnsglobe" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
