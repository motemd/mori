#!/bin/sh
# mori installer — served as https://get.motemd.com/install.sh
#   curl -fsSL https://get.motemd.com/install.sh | sh
# Installs the latest Linux x86_64 release into ~/.local (no root): binary, desktop entry, icons,
# MIME association. Verifies SHA256SUMS, and its GPG signature when gpg is available.
#   MOTE_CHANNEL=stable|beta   default stable, falling back to beta while no stable release exists
#   MOTE_VERSION=0.9.0-beta.1  pin a version
# Uninstall: ~/.local/opt/mori/install.sh --uninstall
set -eu
BASE=https://get.motemd.com
REPO=https://github.com/motemd/mori
FPR="2E25 9EF2 B369 0ECE 0B3F 56D9 6658 9312 CB84 475F"
arch=$(uname -m); [ "$arch" = x86_64 ] || { echo "mori: only x86_64 Linux builds exist yet (this is $arch)" >&2; exit 1; }
command -v curl >/dev/null 2>&1 || { echo "mori: curl is required" >&2; exit 1; }
chan=${MOTE_CHANNEL:-stable}
ver=${MOTE_VERSION:-}
[ -n "$ver" ] || ver=$(curl -fsSL "$BASE/latest/$chan" 2>/dev/null || true)
[ -n "$ver" ] || { chan=beta; ver=$(curl -fsSL "$BASE/latest/beta"); }
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT INT TERM
dl="$REPO/releases/download/v$ver"; tb="mori-$ver-linux-x86_64.tar.xz"
echo "mori $ver ($chan)"
curl -fsSL -o "$tmp/$tb" "$dl/$tb"
curl -fsSL -o "$tmp/SHA256SUMS" "$dl/SHA256SUMS"
curl -fsSL -o "$tmp/SHA256SUMS.asc" "$dl/SHA256SUMS.asc"
(cd "$tmp" && grep " $tb\$" SHA256SUMS | sha256sum -c --quiet -) || { echo "mori: checksum mismatch — not installing" >&2; exit 1; }
if command -v gpg >/dev/null 2>&1; then
  curl -fsSL -o "$tmp/mori.asc" "$BASE/mori.asc"
  GNUPGHOME=$tmp/gnupg; mkdir -m 700 "$GNUPGHOME"; export GNUPGHOME
  gpg -q --import "$tmp/mori.asc" 2>/dev/null
  if gpg -q --verify "$tmp/SHA256SUMS.asc" "$tmp/SHA256SUMS" 2>/dev/null; then echo "signature: good ($FPR)"; else echo "mori: signature verification failed — not installing" >&2; exit 1; fi
else
  echo "gpg not found: checksum verified, signature not checked"
fi
tar -xJf "$tmp/$tb" -C "$tmp"
sh "$tmp/mori/install.sh"
