class GitForeach < Formula
  desc "Run a command in each git repository in a directory"
  homepage "https://github.com/marcfrederick/git-foreach"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/marcfrederick/git-foreach/releases/download/v0.4.2/git-foreach-aarch64-apple-darwin.tar.xz"
      sha256 "73ddda2874d4842e019970e09beaa5fcfe7530faa7676667e83f4274c1f136de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/marcfrederick/git-foreach/releases/download/v0.4.2/git-foreach-x86_64-apple-darwin.tar.xz"
      sha256 "76536f548d1b8c7e8c720bbc099e31d945ba9bf6c33c3f7fc55e1767aacbb424"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/marcfrederick/git-foreach/releases/download/v0.4.2/git-foreach-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "c7f461b36e0d462bc8228897540ab763ed9d04a61bf59d59f7cfad0e5109cb56"
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
