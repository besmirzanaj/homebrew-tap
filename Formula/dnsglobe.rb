class Dnsglobe < Formula
  desc "Global DNS propagation checker TUI — watch a DNS record propagate across 39 public resolvers worldwide, on a world map in your terminal"
  homepage "https://github.com/besmirzanaj/dnsglobe"
  version "0.2.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.2.6/dnsglobe-aarch64-apple-darwin.tar.gz"
      sha256 "e4f36823b5d727964d349851af4a6043f7b77b330deeee4a9a9db8303ca258b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.2.6/dnsglobe-x86_64-apple-darwin.tar.gz"
      sha256 "fa25d339cb41403fc5047799aac9501745c08c11ab853ea63efff38fdfb3413c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.2.6/dnsglobe-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aa2caa39f4464d784a008609011606ff57bb0d629d207011afcf75d1bbed9f86"
    end
    if Hardware::CPU.intel?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.2.6/dnsglobe-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fd63c26ebf79149dd4c39c1b7e95a4c96cdcf02f15c5df7303d248282fcf6908"
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
