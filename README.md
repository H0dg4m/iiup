# iiup

Git tabanlı **dotfiles** güvenli güncelleyici. Varsayılan rice yok — takip edeceğin repo’yu sen seçersin.

1. Upstream’te yenilik var mı bakar  
2. Varsa seçtiğin dosyaları yedekler  
3. `git pull` (+ isteğe bağlı kurulum komutu)  
4. Beğenirsen `ok`, bozulursa `restore`

---

## Kurulum (tak-çalıştır)

```bash
curl -fsSL https://raw.githubusercontent.com/H0dg4m/iiup/main/install.sh | bash
```

veya:

```bash
git clone https://github.com/H0dg4m/iiup.git ~/.local/share/iiup
~/.local/share/iiup/install.sh
```

`install.sh` symlink kurar ve hemen `iiup setup` açar.

`~/.local/bin` PATH’te olmalı (`fish_add_path ~/.local/bin`).

---

## Setup’ta ne sorulur?

1. **Git URL** — kendi dots’un veya herhangi bir public repo  
2. **Branch / tag** — varsayılan `main`  
3. **Yerel klasör** — varsayılan `~/.local/share/src/<repo>`  
4. **Pull sonrası komut** — `./install.sh`, `./setup`, boş = sadece git  

Yedek listesi: `~/.config/iiup/paths.list` (sonra düzenlemen yeterli).

---

## Günlük kullanım

```bash
iiup check     # yenilik var mı?
iiup update    # yedek + pull + kur  (önce commitleri gösterir, onay ister)
iiup ok        # sorun yok → yedeği sil
iiup restore   # bozuldu → geri al
iiup status    # durum
iiup doctor    # bir şeyler ters mi?
```

Günlük bildirim (isteğe bağlı):

```bash
iiup timer on
```

---

## Komutlar

| Komut | Ne işe yarar |
|---|---|
| `setup` | Dots seç / değiştir |
| `check` | Upstream kontrol |
| `update` | Güvenli güncelle |
| `update --force` | Güncel olsa bile kurulum komutu |
| `update -y` | Onaysız (scriptler için) |
| `ok` | Pending yedeği sil |
| `restore` | Yedeğe dön |
| `backup` | Sadece yedek |
| `status` | Özet |
| `doctor` | Kurulum sağlığı |
| `timer on\|off` | systemd günlük check |

---

## Yedek listesi

`~/.config/iiup/paths.list`:

```bash
$HOME/.config/hypr/custom
$HOME/.config/kitty
$HOME/.config/fish
```

Boş bırakılabilir — o zaman sadece git güncellenir, özel dosya yedeklenmez.

---

## Config

`~/.config/iiup/config` — `setup` yazar. Elle de düzenlenebilir:

```bash
DOTS_NAME="my-dots"
REPO_URL="https://github.com/someone/dotfiles.git"
REPO_DIR="$HOME/.local/share/src/dotfiles"
REPO_BRANCH="main"
UPDATE_CMD="./install.sh"   # veya "" 
```

---

## Dosyalar

| | |
|---|---|
| Uygulama | `~/.local/share/iiup/` |
| Komut | `~/.local/bin/iiup` |
| Ayar | `~/.config/iiup/config` |
| Yedek listesi | `~/.config/iiup/paths.list` |
| Yedekler / log | `~/.local/state/iiup/` |

## Lisans

MIT
