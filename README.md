# Nix config with flake, nix-darwin and home-manager for MacOS (intel and arm)
## 1. Install xcode-cli
This will install the tools to build some packages.
```sh
xcode-select --install
```

## 2. Install nix on MacOS
Please read more on the [nix website](https://nixos.org/download/).
```sh
sh <(curl -L https://nixos.org/nix/install)
```

## 3. CLone this repo
Clone this repo to 
```sh
~/.config/nix-darwin
```

## 4. Install nix-darwin
```sh
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix-darwin#mbp
```

## 5. Using nix-darwin
After installing, you can run the following command to apply changes to your system:
```sh
darwin-rebuild switch --flake ~/.config/nix-darwin#mbp
```

## 6. Updating flake
Update all flake inputs
```sh
nix flake update
```