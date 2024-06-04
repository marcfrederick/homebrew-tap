class GitForeach < Formula
  desc "Run a command in each git repository in a directory"
  homepage "https://github.com/marcfrederick/git-foreach"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/marcfrederick/git-foreach/releases/download/v0.1.1/git-foreach-aarch64-apple-darwin.tar.xz"
      sha256 "c159f59e005031d9e58f0a1db8aa558c25285f5733c311785a9c7b5b6091161f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/marcfrederick/git-foreach/releases/download/v0.1.1/git-foreach-x86_64-apple-darwin.tar.xz"
      sha256 "29a400e47e8b21ae631e92a8de96d647b175c2a414c2b0120642624529fd431e"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/marcfrederick/git-foreach/releases/download/v0.1.1/git-foreach-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "946041c295e62dffefede02ddf3454cee05b4893a4c073a46cf68bfff7039a02"
    end
  end
  license "MIT"

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
