#!/usr/bin/env bash
# iiup tak-çalıştır kurulum
set -euo pipefail

REPO="${IIUP_REPO:-https://github.com/H0dg4m/iiup.git}"
DEST="${IIUP_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/iiup}"

need() { command -v "$1" >/dev/null 2>&1 || { echo "gerekli: $1" >&2; exit 1; }; }
need git

if [[ -d "$DEST/.git" ]]; then
  echo "==> Güncelleniyor: $DEST"
  git -C "$DEST" pull --ff-only
else
  echo "==> Klonlanıyor: $REPO → $DEST"
  mkdir -p "$(dirname "$DEST")"
  git clone "$REPO" "$DEST"
fi

chmod +x "$DEST/iiup" "$DEST/install.sh"
"$DEST/iiup" install-link

echo
echo "Sırada: takip edilecek dots’u seç"
exec "$DEST/iiup" setup
