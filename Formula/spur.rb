# Hand-maintained while sanketsaurav/spur is private: Homebrew can't fetch
# release assets from a private repo, so this builds from source over SSH
# access to GitHub. Once the repo is public, spur's release workflow publishes
# a goreleaser cask (Casks/spur.rb) instead — delete this file at that point.
class Spur < Formula
  desc "A full dev stack for every git worktree"
  homepage "https://github.com/sanketsaurav/spur"
  url "git@github.com:sanketsaurav/spur.git",
      using:    :git,
      tag:      "v0.3.0",
      revision: "4b05db315793e4fc8333454c21d5f0e6910c256a"
  license "MIT"
  head "git@github.com:sanketsaurav/spur.git", using: :git, branch: "master"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/sanketsaurav/spur/internal/version.Version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/spur version")
    assert_match "no spur.toml", shell_output("#{bin}/spur status 2>&1", 1)
  end
end
