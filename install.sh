#!/usr/bin/env bash
# iiup plug-and-play installer / tak-çalıştır kurulum
set -euo pipefail

REPO="${IIUP_REPO:-https://github.com/H0dg4m/iiup.git}"
DEST="${IIUP_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/iiup}"

# Language: IIUP_LANG=en|tr, else LANG
_loc="${IIUP_LANG:-${LC_ALL:-${LC_MESSAGES:-${LANG:-en}}}}"
case "${_loc,,}" in
  tr|tr_*|*.tr) _L=tr ;;
  *) _L=en ;;
esac
m() { if [[ "$_L" == "tr" ]]; then printf '%s' "$2"; else printf '%s' "$1"; fi; }

need() { command -v "$1" >/dev/null 2>&1 || { echo "$(m "required:" "gerekli:") $1" >&2; exit 1; }; }
need git

if [[ -d "$DEST/.git" ]]; then
  echo "==> $(m "Updating:" "Güncelleniyor:") $DEST"
  git -C "$DEST" pull --ff-only
else
  echo "==> $(m "Cloning:" "Klonlanıyor:") $REPO → $DEST"
  mkdir -p "$(dirname "$DEST")"
  git clone "$REPO" "$DEST"
fi

chmod +x "$DEST/iiup" "$DEST/install.sh"
"$DEST/iiup" install-link

echo
echo "$(m "Next: choose which dots repo to track" "Sırada: takip edilecek dots’u seç")"
exec "$DEST/iiup" setup
