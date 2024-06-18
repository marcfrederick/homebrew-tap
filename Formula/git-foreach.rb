class GitForeach < Formula
  desc "Run a command in each git repository in a directory"
  homepage "https://github.com/marcfrederick/git-foreach"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/marcfrederick/git-foreach/releases/download/v0.4.0/git-foreach-aarch64-apple-darwin.tar.xz"
      sha256 "e5417e9a21434b3bcbcf97fd966633a4b1e57bdc16606afb18543059d7eb3b17"
    end
    if Hardware::CPU.intel?
      url "https://github.com/marcfrederick/git-foreach/releases/download/v0.4.0/git-foreach-x86_64-apple-darwin.tar.xz"
      sha256 "f719bcd84b5967623bf8b7277485e939d7b347d0374d9f2778dab90d577682fe"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/marcfrederick/git-foreach/releases/download/v0.4.0/git-foreach-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0d78561bd5e4551da6b0e7e986aa31d380861f6c94efe4dd240176977aaeb0af"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
      bin.install "git-foreach"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "git-foreach"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "git-foreach"
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
