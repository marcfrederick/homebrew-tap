class Assume < Formula
  desc      "Interactive AWS profile switcher with automatic SSO login support"
  homepage "https://github.com/marcfrederick/assume"
  url      "https://github.com/marcfrederick/assume/archive/refs/tags/v0.0.2.tar.gz"
  sha256   "8478e42aa8b22a8c0157de2f8ff5227854124762bc44b5ea566aaab972eb396d"
  license   "GPL-3.0-or-later"
  head      "https://github.com/marcfrederick/assume.git", branch: "main"

  depends_on "awscli"
  depends_on "bash"
  depends_on "fzf"
  depends_on "yq"

  def install
    bin.install "assume"
  end

  def caveats
    <<~EOS
      To use assume as a shell function that sets environment variables in your current shell,
      add the following to your shell configuration file:

      For Bash/Zsh (~/.bashrc or ~/.zshrc):
        assume() {
          eval "$(command assume "$@")"
        }

      For Fish (~/.config/fish/config.fish):
        function assume
            eval (command assume $argv)
        end

      Then restart your shell or source your configuration file.
    EOS
  end

  test do
    assert_predicate bin/"assume", :exist?
    assert_predicate bin/"assume", :executable?
  end
end
