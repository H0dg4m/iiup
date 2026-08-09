# iiup

Git tabanlı **dotfiles** için güvenli güncelleyici.

Belirli bir rice’a veya projeye bağlı değildir. Takip edilecek repo’yu **sen** seçersin — kendi dots’un, bir fork, başka birinin public rice’ı… hepsi olur.

**Ne yapar?**

1. Upstream’te yeni commit var mı bakar  
2. Varsa, senin seçtiğin dosyaları yedekler  
3. `git pull` (+ isteğe bağlı kurulum komutu) çalıştırır  
4. Beğenmezsen yedeği geri yüklersin; beğenirsen yedeği silersin  

Upstream yoksa kurulum komutu **çalışmaz** — gereksiz yeniden kurulum yok.

---

## Gereksinimler

- `bash`, `git`
- (isteğe bağlı) `notify-send` — masaüstü bildirimi  
- (isteğe bağlı) `systemctl --user` — günlük kontrol timer’ı  
- (isteğe bağlı) `rsync` — geri yüklemede tercih edilir  

---

## Kurulum

```bash
git clone https://github.com/H0dg4m/iiup.git ~/.local/share/iiup
chmod +x ~/.local/share/iiup/iiup
~/.local/share/iiup/iiup install-link
```

`~/.local/bin` PATH’te olmalı:

```bash
# fish
fish_add_path ~/.local/bin

# bash / zsh — ~/.bashrc veya ~/.zshrc
export PATH="$HOME/.local/bin:$PATH"
```

Ardından ilk kurulum:

```bash
iiup setup
```

Varsayılan bir dots reposu **yok**. Config tanımlı değilken TTY’de `iiup check` / `iiup update` da otomatik `setup`’a düşer.

İsteğe bağlı günlük kontrol:

```bash
iiup enable-timer
```

---

## `iiup setup` ne sorar?

| Soru | Örnek / not |
|---|---|
| Git repo URL | `https://github.com/sen/dotfiles.git` veya `git@…` |
| Branch / tag | `main`, `master`, veya sabit bir tag |
| Kısa isim | Bildirimlerde görünür (örn. `my-dots`) |
| Yerel clone yolu | Öneri: `~/.local/share/src/<repo-adı>` |
| Şimdi klonlansın mı? | Evet dersen clone + kurulum komutu tahmini |
| Pull sonrası komut | `./install.sh`, `./setup`, `stow -R …`, veya **boş** = sadece git |
| Hyprland yedek yolları? | Varsayılan **hayır** — istersen eklenir |

Kurulum komutu dots’unun kendi betiğidir; iiup ne çalıştıracağını bilmez — sen yazarsın.

Dots değiştirmek için tekrar `iiup setup` yeterli.

---

## Tipik kullanım

```bash
iiup check          # yeni sürüm var mı?
iiup update         # gerekirse yedek + pull + UPDATE_CMD
# bir süre dene…
iiup ok             # sorun yok → pending yedeği sil
# veya
iiup restore        # bozuldu → son yedeğe dön
```

Zorla yeniden kurulum (zaten güncelsen bile):

```bash
iiup update --force
```

---

## Komutlar

| Komut | Açıklama |
|---|---|
| `iiup setup` | Takip edilecek dots’u tanımla / değiştir |
| `iiup check` | Upstream’te yeni sürüm var mı bak |
| `iiup watch` | Sessiz kontrol (timer; sadece güncelleme varsa bildir) |
| `iiup update` | Gerekirse yedek + pull + `UPDATE_CMD` |
| `iiup update --force` | Güncel olsa bile `UPDATE_CMD` çalıştır |
| `iiup ok` | Pending yedeği sil (onay) |
| `iiup restore [id\|latest]` | Yedeği geri yükle |
| `iiup backup` | Sadece yedek al |
| `iiup status` | Durum, pending, timer |
| `iiup list` | Yedek listesi |
| `iiup health` | Yedek yollarının hâlâ durduğunu kontrol et |
| `iiup enable-timer` | Günlük otomatik `watch` |
| `iiup disable-timer` | Timer kapat |
| `iiup install-link` | `~/.local/bin/iiup` symlink |
| `iiup help` | Yardım |

---

## Yedeklenecek dosyalar

Liste: `~/.config/iiup/paths.list` — satır başına bir yol. `#` yorum satırı. `~` ve `$HOME` kullanılabilir.

```bash
# örnek
$HOME/.config/hypr/custom
$HOME/.config/kitty
$HOME/.config/fish/config.fish
$HOME/.config/waybar
```

Config içinde dizi olarak da eklenebilir:

```bash
BACKUP_EXTRA=(
  "$HOME/.config/nvim"
  "$HOME/.local/share/fonts"
)
```

Liste boşsa `update` yine çalışır; sadece yedek alınacak bir şey bulunamazsa uyarı verir.

---

## Config

Dosya: `~/.config/iiup/config` (`iiup setup` yazar; elle de düzenleyebilirsin).

```bash
DOTS_NAME="my-dots"
REPO_URL="https://github.com/someone/dotfiles.git"
REPO_DIR="$HOME/.local/share/src/dotfiles"
REPO_BRANCH="main"

# Pull sonrası (boş = sadece git pull)
UPDATE_CMD="./install.sh"
# UPDATE_CMD="stow -R -t $HOME ."
# UPDATE_CMD="./setup install --force"

NOTIFY=1
KEEP_FAILED_BACKUPS=5
CHECK_ON_CALENDAR="daily"   # veya: *-*-* 10:00:00
```

### Farklı dots örnekleri

**Sadece git** (kurulum betiği yok):

```bash
UPDATE_CMD=""
```

**GNU Stow:**

```bash
UPDATE_CMD="stow -R -t \"$HOME\" ."
```

**Kendi install script’in:**

```bash
UPDATE_CMD="bash ./install.sh"
```

**end-4 / illogical-impulse tarzı** (istersen; varsayılan değil):

```bash
UPDATE_CMD="./setup install --force --skip-allgreeting -s"
```

---

## Dosya konumları (XDG)

| Ne | Nerede |
|---|---|
| Uygulama | `~/.local/share/iiup/` |
| Komut | `~/.local/bin/iiup` |
| Ayarlar | `~/.config/iiup/config` |
| Yedek listesi | `~/.config/iiup/paths.list` |
| Yedekler / log | `~/.local/state/iiup/` |
| Dots clone | `config` içindeki `REPO_DIR` |
| systemd timer | `~/.config/systemd/user/iiup-check.*` |

Projeyi taşıdıktan sonra:

```bash
iiup install-link
iiup enable-timer   # timer kullanıyorsan
```

---

## Notlar

- iiup, dots’unun içeriğini “bilmez”; sadece git + senin verdiğin komutu çalıştırır.  
- Güncelleme sonrası yedek **otomatik silinmez** — `iiup ok` ile onaylarsın.  
- Repo kirliyse güncellemede stash alınır.  
- Root ile çalıştırma.

## Lisans

MIT — kullan, fork’la, paylaş.
