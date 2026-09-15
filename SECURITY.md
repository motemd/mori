# Security policy

**Report privately to support@motemd.com** with "security" in the subject. Please include the version (`mori --version`), your distribution, and steps or a file that reproduces the problem. Do not open a public issue for a vulnerability.

You will get an acknowledgement within 3 business days and a fix or a mitigation plan within 30 days for confirmed reports. Credit is given in the release notes unless you prefer otherwise.

**Supported versions:** the latest release of each channel (`stable`, and `beta` when one is out).

**What mori does not do:** it makes no network connections except an optional update check (`updates.motemd.com`, no identifier attached) and licence activation when you enter a key. It does not send document contents anywhere.

Downloads are signed: verify `SHA256SUMS.asc` with the release key (fingerprint `2E25 9EF2 B369 0ECE 0B3F 56D9 6658 9312 CB84 475F`, https://get.motemd.com/mori.asc).
