class GitForeach < Formula
  desc "Run a command in each git repository in a directory"
  homepage "https://github.com/marcfrederick/git-foreach"
  version "0.4.3"

  deprecate! date: "2025-07-02", because: "has been replaced by the `git-foreach` cask", replacement_cask: "git-foreach"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/marcfrederick/git-foreach/releases/download/v0.4.3/git-foreach-aarch64-apple-darwin.tar.xz"
      sha256 "38a1450fae131fe9abf010309650eace7cb4b6c4b892c1690fffa13e243d5d91"
    end
    if Hardware::CPU.intel?
      url "https://github.com/marcfrederick/git-foreach/releases/download/v0.4.3/git-foreach-x86_64-apple-darwin.tar.xz"
      sha256 "120c48fc7f0714549c7ae8478b871d6b0e9f92e7461540ffd4cbea59ae7f96a9"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/marcfrederick/git-foreach/releases/download/v0.4.3/git-foreach-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "d1987a18e7668a79057c7e3da201c578f8ce19cb35a515ad26eaf0a25f4d5db5"
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    bin.install "git-foreach" if OS.mac? && Hardware::CPU.arm?
    bin.install "git-foreach" if OS.mac? && Hardware::CPU.intel?
    bin.install "git-foreach" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
