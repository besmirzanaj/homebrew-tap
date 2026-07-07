class Dnsglobe < Formula
  desc "Global DNS propagation checker TUI — watch a DNS record propagate across 39 public resolvers worldwide, on a world map in your terminal"
  homepage "https://github.com/besmirzanaj/dnsglobe"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.3.2/dnsglobe-aarch64-apple-darwin.tar.gz"
      sha256 "b6e50ea729f452d3ab476097e8ae0186f71cafb5b057904295f25f3a0f5c6132"
    end
    if Hardware::CPU.intel?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.3.2/dnsglobe-x86_64-apple-darwin.tar.gz"
      sha256 "536c37ffca6c2920798b749369171e6c6132b23e4bbe65dc7f7257cf8728939d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.3.2/dnsglobe-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2c500bb36ff6c04c6ec2469a43d32ef9c3c95610e0dea12c8f52e8caf9b13eb1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/besmirzanaj/dnsglobe/releases/download/v0.3.2/dnsglobe-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1e985d5bcc241fb416bf0e2844faa2204c6a244354dc5a0be243c6586acbd304"
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
