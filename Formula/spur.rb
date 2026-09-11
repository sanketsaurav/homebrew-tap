# Hand-maintained while sanketsaurav/spur is private: Homebrew can't fetch
# release assets from a private repo, so this builds from source over SSH
# access to GitHub. Once the repo is public, spur's release workflow publishes
# a goreleaser cask (Casks/spur.rb) instead — delete this file at that point.
class Spur < Formula
  desc "A full dev stack for every git worktree"
  homepage "https://github.com/sanketsaurav/spur"
  url "git@github.com:sanketsaurav/spur.git",
      using:    :git,
      tag:      "v0.2.1",
      revision: "36f36fda18554f1a1b68316dcac59113b5939a57"
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
