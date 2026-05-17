# dotfiles

My personal configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Components

| Package | Description |
| :--- | :--- |
| **DankMaterialShell** | Custom Material Shell configuration and themes |
| **fish** | Fish shell configuration |
| **ghostty** | Ghostty terminal configuration |
| **git** | Git user configuration |
| **helix** | Helix editor configuration and languages |
| **niri** | Niri window manager (Wayland) configuration |
| **shell** | Generic `.bashrc` and `.profile` |
| **tmux** | Tmux terminal multiplexer |
| **zathura** | Zathura PDF viewer |
| **zed** | Zed editor settings and themes |
| **zellij** | Zellij terminal workspace |

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/shans10/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Use GNU Stow to symlink configurations:
   ```bash
   # To stow a specific package
   stow fish

   # To stow everything
   stow */

   # To unstow a package
   stow -D fish
   ```

> [!TIP]
> **Handling Conflicts:** If Stow fails because a file already exists in the target directory (e.g., a default `~/.bashrc`), you must back up or delete the existing file before running the stow command.


## Prerequisites

- [GNU Stow](https://www.gnu.org/software/stow/)
- Respective applications for each configuration package.

## DankMaterialShell Notes

If you run DankMaterialShell (DMS) via systemd instead of spawning it directly from Niri (e.g., `spawn-at-startup "dms" "run"`), Niri's environment variables will not apply.

To fix this, add the required variable directly to the systemd service:

1. Edit the service:
   ```bash
   systemctl --user edit dms
   ```

2. Add the environment variable:
   ```ini
   [Service]
   Environment=DMS_MODAL_LAYER=overlay
   ```

3. Reload and restart:
   ```bash
   systemctl --user daemon-reexec
   systemctl --user restart dms
   ```
