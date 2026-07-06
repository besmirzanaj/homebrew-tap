class Dnsglobe < Formula
  desc "Global DNS propagation checker TUI — watch a DNS record propagate across 39 public resolvers worldwide, on a world map in your terminal"
  homepage "https://github.com/besmirzanaj/dnsglobe"
  version "0.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.2.4/dnsglobe-aarch64-apple-darwin.tar.xz"
      sha256 "6508d4f98dfd12021d4aa42d6543782cf0fe7e6ecf1ba15db46be910fe71e860"
    end
    if Hardware::CPU.intel?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.2.4/dnsglobe-x86_64-apple-darwin.tar.xz"
      sha256 "d3222a245d689a46407715153a0864d1ce0de0ca298c4a0f04ec1c509d9b922a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.2.4/dnsglobe-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "092c4f61ce9af2f9f6015218ba07b0467f086f1d214eea766362913f0c4359a3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.2.4/dnsglobe-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3d3bd539205a6f1e22b806283461239928f4ef286530945ae550eaa9685d4529"
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
