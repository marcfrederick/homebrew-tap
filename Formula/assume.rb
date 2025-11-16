class Assume < Formula
  desc      "Interactive AWS profile switcher with automatic SSO login support"
  homepage "https://github.com/marcfrederick/assume"
  url      "https://github.com/marcfrederick/assume/archive/refs/tags/v0.0.1.tar.gz"
  sha256   "915017c703e0501918a4d801c734a14b32568bbfb0ca10b738934170a6a913b9"
  license   "GPL-3.0-or-later"
  head      "https://github.com/marcfrederick/assume.git", branch: "main"

  depends_on "awscli"
  depends_on "fzf"

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
