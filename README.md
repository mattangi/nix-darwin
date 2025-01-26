# the series of commands

```sh
xcode-select --install

sh <(curl -L https://nixos.org/nix/install)

nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix-darwin#mbp

darwin-rebuild switch --flake ~/.config/nix-darwin#mbp

Nix flake update
```