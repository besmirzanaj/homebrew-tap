class Dnsglobe < Formula
  desc "Global DNS propagation checker TUI — watch a DNS record propagate across 39 public resolvers worldwide, on a world map in your terminal"
  homepage "https://github.com/besmirzanaj/dnsglobe"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.5.1/dnsglobe-aarch64-apple-darwin.tar.gz"
      sha256 "c4d8113a8766c42290a47a1ebe02ad8f2ea7891a46524b200ad58e7a1eec98ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.5.1/dnsglobe-x86_64-apple-darwin.tar.gz"
      sha256 "fc6bb141ca3f0b649485aecea0847e051ade10cb5d03ffa99ae6ee26440a2f21"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.5.1/dnsglobe-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b16be80a3c2be5731d069faa5826e5a50eb7c7710e36ea458c9b1583b21ad8a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.5.1/dnsglobe-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a3d0e55215215047b1d6218245bbedb5bfe5cfeffcbe8dcca3ef869a7563352e"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "dnsglobe"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dnsglobe"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dnsglobe"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dnsglobe"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
