#!/usr/bin/env bash
# Weekly check: if ialexsilva/dnsbench-cli has a newer release than the pinned
# formula, regenerate Formula/dnsbench.rb with the new version + sha256s and
# commit it to the default branch. Run by .github/workflows/bump-dnsbench.yml.
set -euo pipefail

UPSTREAM="ialexsilva/dnsbench-cli"
FORMULA="Formula/dnsbench.rb"

latest=$(gh api "repos/${UPSTREAM}/releases/latest" --jq .tag_name)   # e.g. v0.6.0
ver="${latest#v}"
cur=$(sed -nE 's/^[[:space:]]*version "([^"]+)".*/\1/p' "$FORMULA" | head -1)

echo "current=${cur} latest=${ver}"
if [[ "$ver" == "$cur" ]]; then
  echo "Formula already at ${ver}; nothing to do."
  exit 0
fi

base="https://github.com/${UPSTREAM}/releases/download/${latest}"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

sha() {
  local name="$1"
  curl -fsSL -o "${tmp}/${name}" "${base}/${name}"
  sha256sum "${tmp}/${name}" | cut -d' ' -f1
}

sha_darwin_arm=$(sha dnsbench-darwin-arm64.tar.gz)
sha_darwin_intel=$(sha dnsbench-darwin-amd64.tar.gz)
sha_linux_intel=$(sha dnsbench-linux-amd64.tar.gz)

cat > "$FORMULA" <<EOF
class Dnsbench < Formula
  desc "Benchmark and diagnose recursive DNS resolvers from your own network"
  homepage "https://github.com/${UPSTREAM}"
  version "${ver}"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "${base}/dnsbench-darwin-arm64.tar.gz"
      sha256 "${sha_darwin_arm}"
    end
    on_intel do
      url "${base}/dnsbench-darwin-amd64.tar.gz"
      sha256 "${sha_darwin_intel}"
    end
  end

  on_linux do
    on_intel do
      url "${base}/dnsbench-linux-amd64.tar.gz"
      sha256 "${sha_linux_intel}"
    end
  end

  def install
    bin.install "dnsbench"
  end

  test do
    assert_match "dnsbench version #{version}", shell_output("#{bin}/dnsbench --version")
  end
end
EOF

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git add "$FORMULA"
git commit -m "dnsbench: bump ${cur} -> ${ver}"
git push

{
  echo "### dnsbench bumped"
  echo ""
  echo "\`${cur}\` → \`${ver}\`"
} >> "${GITHUB_STEP_SUMMARY:-/dev/null}"
