class TofuTargetFile < Formula
  desc      "A simple shell script that generates target files for OpenTofu."
  homepage "https://github.com/marcfrederick/tofu-target-file"
  url      "https://github.com/marcfrederick/tofu-target-file/archive/refs/tags/v1.0.0.tar.gz"
  sha256   "13e62f274a74bd25a9ae815e7f56d3a4b852e45c40861dcff311607d0038f215"
  license   "GPL-3.0-or-later"
  head      "https://github.com/marcfrederick/tofu-target-file.git", branch: "main"

  depends_on "bash"

  def install
    bin.install "tofu-target-file"
  end

  test do
    assert_predicate bin/"tofu-target-file", :exist?
    assert_predicate bin/"tofu-target-file", :executable?
  end
end
