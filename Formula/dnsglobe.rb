class Dnsglobe < Formula
  desc "Global DNS propagation checker TUI — watch a DNS record propagate across 39 public resolvers worldwide, on a world map in your terminal"
  homepage "https://github.com/besmirzanaj/dnsglobe"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.5.2/dnsglobe-aarch64-apple-darwin.tar.gz"
      sha256 "2bcd8bdbf8a202f6cf5249de7994962b413e9a5e5aae783eb05ba26331aa4560"
    end
    if Hardware::CPU.intel?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.5.2/dnsglobe-x86_64-apple-darwin.tar.gz"
      sha256 "9d28ae47bdd1ae26cbc50cc3085508d7e61bfb535917b940ee5749d284192ddd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.5.2/dnsglobe-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "919090bc08d0b8cf485d6138bea38a88ff15e765e9745aa4767e736450098935"
    end
    if Hardware::CPU.intel?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.5.2/dnsglobe-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eb281b8f99af491f3c3cbcab3c0453b96e8983c1147af0ccb4b4c176376ba058"
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
