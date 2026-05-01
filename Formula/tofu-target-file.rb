class TofuTargetFile < Formula
  desc      "A simple shell script that generates target files for OpenTofu."
  homepage "https://github.com/marcfrederick/tofu-target-file"
  url      "https://github.com/marcfrederick/tofu-target-file/archive/refs/tags/v1.0.1.tar.gz"
  sha256   "525547b06126b135b4083ff4be74548ad5e3f9e54c1c904ed9aa737768c1ef72"
  license   "GPL-3.0-or-later"
  head      "https://github.com/marcfrederick/tofu-target-file.git", branch: "main"

  deprecate! date: "2026-05-01", because: "has been replaced by the `tofu-target-file` cask", replacement_cask: "tofu-target-file"

  depends_on "bash"

  def install
    bin.install "tofu-target-file"
  end

  test do
    assert_predicate bin/"tofu-target-file", :exist?
    assert_predicate bin/"tofu-target-file", :executable?
  end
end
