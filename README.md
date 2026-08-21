# iiup

Safe **git-based dotfiles** updater. No default rice — you choose which repo to track.

[English](#english) · [Türkçe](#türkçe)

---

## English

1. Checks if upstream has new commits  
2. Backs up the paths you listed  
3. Runs `git pull` (+ optional install command)  
4. Keep it with `ok`, or roll back with `restore`

### Install

```bash
curl -fsSL https://raw.githubusercontent.com/H0dg4m/iiup/main/install.sh | bash
```

or:

```bash
git clone https://github.com/H0dg4m/iiup.git ~/.local/share/iiup
~/.local/share/iiup/install.sh
```

Ensure `~/.local/bin` is on your `PATH` (`fish_add_path ~/.local/bin`).

### Setup asks for

1. **Git URL** — your dots or any public repo  
2. **Branch / tag** — default `main`  
3. **Local folder** — default `~/.local/share/src/<repo>`  
4. **Post-pull command** — `./install.sh`, `./setup`, or empty = git only  

Backup list: `~/.config/iiup/paths.list` (edit anytime).

### Daily use

```bash
iiup check      # updates available?
iiup update     # backup + pull + install (shows commits, asks confirm)
iiup ok         # all good → delete backup
iiup restore    # broken → roll back
iiup status
iiup doctor
iiup timer on   # optional daily notify
```

### Language

UI follows `LANG` / `LC_MESSAGES`. Force with:

```bash
IIUP_LANG=en iiup help
IIUP_LANG=tr iiup help
```

Or add `IIUP_LANG=tr` to `~/.config/iiup/config`.

### Commands

| Command | What it does |
|---|---|
| `setup` | Choose / change dots repo |
| `check` | Upstream check |
| `update` | Safe update |
| `update --force` | Re-run install even if current |
| `update -y` | Skip prompts |
| `ok` | Delete pending backup |
| `restore` | Restore backup |
| `backup` | Backup only |
| `status` | Summary |
| `doctor` | Health check |
| `timer on\|off` | systemd daily check |

### Backup list

`~/.config/iiup/paths.list`:

```bash
$HOME/.config/hypr/custom
$HOME/.config/kitty
$HOME/.config/fish
```

Empty is fine — then only git is updated.

### Config

`~/.config/iiup/config`:

```bash
DOTS_NAME="my-dots"
REPO_URL="https://github.com/someone/dotfiles.git"
REPO_DIR="$HOME/.local/share/src/dotfiles"
REPO_BRANCH="main"
UPDATE_CMD="./install.sh"   # or ""
# IIUP_LANG=en
```

### Paths

| | |
|---|---|
| App | `~/.local/share/iiup/` |
| Command | `~/.local/bin/iiup` |
| Icon | `~/.local/share/icons/hicolor/*/apps/iiup.png` |
| Desktop entry | `~/.local/share/applications/iiup.desktop` |
| Config | `~/.config/iiup/config` |
| Backup list | `~/.config/iiup/paths.list` |
| Backups / logs | `~/.local/state/iiup/` |

`iiup install-link` also installs the app icon used in desktop notifications.

---

## Türkçe

Git tabanlı **dotfiles** güvenli güncelleyici. Varsayılan rice yok — takip edeceğin repo’yu sen seçersin.

1. Upstream’te yenilik var mı bakar  
2. Seçtiğin dosyaları yedekler  
3. `git pull` (+ isteğe bağlı kurulum komutu)  
4. Beğenirsen `ok`, bozulursa `restore`

### Kurulum

```bash
curl -fsSL https://raw.githubusercontent.com/H0dg4m/iiup/main/install.sh | bash
```

veya:

```bash
git clone https://github.com/H0dg4m/iiup.git ~/.local/share/iiup
~/.local/share/iiup/install.sh
```

`~/.local/bin` PATH’te olmalı (`fish_add_path ~/.local/bin`).

### Setup ne sorar?

1. **Git URL**  
2. **Branch / tag** (varsayılan `main`)  
3. **Yerel klasör**  
4. **Pull sonrası komut** (boş = sadece git)  

Yedek listesi: `~/.config/iiup/paths.list`

### Günlük kullanım

```bash
iiup check
iiup update
iiup ok        # sorun yok
iiup restore   # bozuldu
iiup doctor
iiup timer on
```

### Dil

`LANG` / `LC_MESSAGES` otomatik. Zorla:

```bash
IIUP_LANG=tr iiup help
IIUP_LANG=en iiup help
```

Config’e `IIUP_LANG=tr` da yazabilirsin.

### Lisans

MIT
