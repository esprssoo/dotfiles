## Dotfiles

- [Neovim Nightly](https://github.com/neovim/neovim)
- [Fish Shell](https://github.com/fish-shell/fish-shell)
- [Ghostty](https://ghostty.org)

## Usage

Either copy and paste anything you like, or use *Nix*
[home-manager](https://github.com/nix-community/home-manager) (recommended)

- Clone the repository (e.g into `~/.dotfiles`) and cd into it (`cd ~/.dotfiles`)
- Install [Nix](https://nixos.org/download) with [flakes enabled](https://nixos.wiki/wiki/Flakes)
- Edit `flakes.nix`, `home.nix` to your liking (add/remove packages, configs, etc.)
- **Double check your nix config**, you'll probably want to edit them for yourself, especially things like the git config
- On your first run: `nix run home-manager/master -- switch --flake ~/.dotfiles`
- On subsequent runs: `home-manager switch --flake ~/.dotfiles`
