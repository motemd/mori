# mori

**A native live Markdown editor for Linux.** Edit in place like Typora, without a web engine: nothing runs while you read, typing uses a fraction of one core, and the file on disk stays exactly what you typed.

Website and docs: **[motemd.com](https://motemd.com)** · 1.0 is out — 14-day trial, then a licence ($19.99 once, up to three personal devices).

This repository is the product home — releases, issues, discussions and the security policy. The source is not public; the [benchmark harness](https://motemd.com/benchmarks) is.

> **The app was called `mote` until 2026-09-15.** Same app, same licence keys, same `motemd.com`. The commands below are the ones that work today; the packages take the new name with the next release, and this page changes with them.

## Install

| Form | Where it runs | How |
|---|---|---|
| **apt repository** (.deb) | Ubuntu 22.04+, Debian 12+ | see below |
| **.deb** | Ubuntu 22.04+, Debian 12+ | [Releases](https://github.com/motemd/mori/releases) → `sudo apt install ./mote_<version>_amd64.deb` |
| **AppImage** | Ubuntu 22.04+, any glibc 2.35+ distribution | download, `chmod +x`, run |
| **Terminal install** (tarball, no root) | Ubuntu 22.04+, any glibc 2.35+ distribution | `curl -fsSL https://get.motemd.com/install.sh \| sh` |
| **Flatpak** | any distribution | from our own repository, see below |

```sh
# apt repository
sudo install -d -m 0755 /etc/apt/keyrings
curl -fsSL https://get.motemd.com/mote.asc | sudo tee /etc/apt/keyrings/mote.asc >/dev/null
echo "deb [signed-by=/etc/apt/keyrings/mote.asc] https://get.motemd.com/apt stable main" | sudo tee /etc/apt/sources.list.d/mote.list
sudo apt update && sudo apt install mote

# Flatpak (the GNOME runtime comes with it, from Flathub)
flatpak install --from https://get.motemd.com/flatpak/mote-stable.flatpakref

# Tarball into ~/.local (no root) — verifies the checksum and signature
curl -fsSL https://get.motemd.com/install.sh | sh
# remove: ~/.local/opt/mote/install.sh --uninstall
```

The `.deb`, the AppImage and the tarball bundle their own GTK 4 / libadwaita (built on Ubuntu 22.04, glibc 2.35), so every distribution runs the same binary with the same behaviour.

## Verify a download

Every release ships `SHA256SUMS` and a detached signature by the release key (ed25519, fingerprint `2E25 9EF2 B369 0ECE 0B3F 56D9 6658 9312 CB84 475F`).

```sh
curl -fsSL https://get.motemd.com/mori.asc | gpg --import
gpg --verify SHA256SUMS.asc SHA256SUMS && sha256sum -c SHA256SUMS
```

## Requirements

Linux x86_64. X11 or Wayland. Korean and other IME input through ibus or fcitx5. macOS and Windows are in development.

## Feedback

- Bugs: [Issues](https://github.com/motemd/mori/issues) — please include the version (`mori --version`), your distribution and session (X11/Wayland), and a small `.md` that shows the problem.
- Questions and ideas: [Discussions](https://github.com/motemd/mori/discussions).
- Security: see [SECURITY.md](SECURITY.md).
- Release feed: [releases.atom](https://github.com/motemd/mori/releases.atom).

## Licence

mori is proprietary software. Use is governed by the [terms of service](https://motemd.com/terms). Bundled font: Pretendard (SIL Open Font License 1.1).
