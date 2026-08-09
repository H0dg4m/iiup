# iiup

**illogical-impulse / [dots-hyprland](https://github.com/end-4/dots-hyprland)** için güvenli güncelleyici.

Güncellemeden önce kişisel config’leri yedekler, upstream’te yeni sürüm yoksa boşuna kurulum çalıştırmaz, günlük otomatik kontrol ile haber verir.

## Ne yapar?

1. Upstream’te yeni commit var mı bakar  
2. Varsa: yedek alır → `git pull` → `./setup`  
3. Sen bir süre kullanırsın  
4. Sorun yoksa `iiup ok` ile yedeği siler; bozulursa `iiup restore`

## Kurulum

```bash
chmod +x iiup
./iiup install-link      # ~/.local/bin/iiup
./iiup enable-timer      # günde 1 kez otomatik check
```

Fish kullanıyorsan `~/.local/bin` PATH’te olmalı:

```fish
fish_add_path ~/.local/bin
```

## Kullanım

| Komut | Açıklama |
|---|---|
| `iiup check` | Şimdi kontrol et (güncellemez) |
| `iiup watch` | Sessiz kontrol; sadece güncelleme varsa bildirim |
| `iiup update` | Gerekirse yedek + güncelle |
| `iiup update --force` | Güncel olsa bile `./setup` yenile |
| `iiup ok` | Güncelleme sorunsuz → pending yedeği sil |
| `iiup restore` | Son yedeği geri yükle |
| `iiup status` | Clone yolu, sürüm, timer, yedekler |
| `iiup enable-timer` | Günlük systemd timer aç |
| `iiup disable-timer` | Timer’ı kapat |

Tipik akış:

```bash
iiup update          # veya bildirim gelince
# Hyprland’i bir süre kullan
iiup ok              # sorun yoksa
# iiup restore       # sorun varsa
```

## Dosya konumları

| Ne | Nerede |
|---|---|
| Bu proje (script) | `~/.local/share/iiup` |
| Komut symlink | `~/.local/bin/iiup` → bu script |
| Ayarlar | `~/.config/iiup/config` |
| Ek yedek listesi | `~/.config/iiup/paths.list` |
| Yedekler / log | `~/.local/state/iiup/` |
| dots-hyprland clone | `~/clone/dots-hyprland` (config’den değişir) |
| systemd timer | `~/.config/systemd/user/iiup-check.{timer,service}` |

### Projeyi başka klasöre taşırsam?

Taşıyabilirsin. Sonra **bir kez** yeniden bağla:

```bash
/yeni/yol/iiup/iiup install-link
/yeni/yol/iiup/iiup enable-timer
```

Aksi halde `~/.local/bin/iiup` ve timer eski yolu gösterir.  
`~/.config/iiup` ve `~/.local/state/iiup` taşınmaz; onlar XDG altında kalır.

dots-hyprland clone’u (`~/clone/...`) ayrıdır; proje klasörünü taşımak clone’u etkilemez.

## Config

`~/.config/iiup/config` örneği:

```bash
REPO_DIR="$HOME/clone/dots-hyprland"
REPO_URL="https://github.com/end-4/dots-hyprland.git"
REPO_BRANCH="main"              # veya sabit tag: 2026.05.11
UPDATE_MODE="install"          # install | exp-update | exp-merge
SETUP_ARGS="--force --skip-allgreeting -s"
CHECK_ON_CALENDAR="daily"       # veya *-*-* 10:00:00
NOTIFY=1
```

`CHECK_ON_CALENDAR` değişince: `iiup enable-timer`

## Yedeklenenler (varsayılan)

- `~/.config/hypr/custom/` (keybind, script, vs.)
- `hyprland.lua`, `monitors.lua` / `.conf`, workspaces
- `~/.config/illogical-impulse/` (`config.json` dahil)
- idle / lock conf ve ignore dosyaları

Ek yol için `~/.config/iiup/paths.list` veya config’de `BACKUP_EXTRA`.

## Gereksinimler

- Arch / CachyOS (veya dots-hyprland’in desteklediği distro)
- `git`, `systemctl --user`, `notify-send` (bildirim için)
- Hyprland + illogical-impulse kurulumu

## Lisans

Kişisel / MIT — istediğin gibi kullan, fork’la, paylaş.
