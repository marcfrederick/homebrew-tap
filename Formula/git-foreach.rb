class GitForeach < Formula
  desc "Run a command in each git repository in a directory"
  homepage "https://github.com/marcfrederick/git-foreach"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/marcfrederick/git-foreach/releases/download/v0.4.1/git-foreach-aarch64-apple-darwin.tar.xz"
      sha256 "94bc2042779a36fc592101f015e4bdd834ac3da6c9810dd2149e82eff297e407"
    end
    if Hardware::CPU.intel?
      url "https://github.com/marcfrederick/git-foreach/releases/download/v0.4.1/git-foreach-x86_64-apple-darwin.tar.xz"
      sha256 "b1e96baae5c8712c48e036ec6d700dcf3b6532f194e04e7c942bfbf865c12b2e"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/marcfrederick/git-foreach/releases/download/v0.4.1/git-foreach-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "536dd8de7fe320dba5776b11c0ee8621cf76559053e82bccfa8223e28427dd96"
    end
  end
  license "MIT OR Apache-2.0"

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
