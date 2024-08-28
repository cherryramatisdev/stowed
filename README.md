# How to setup nix

1. Install nix

```sh
$ sh <(curl -L https://nixos.org/nix/install)
```

## Nix darwin

2. Run nix darwin pointing to the config on `~/.config/nix-darwin/flake.nix`

```sh
nix run nix-darwin -- switch --flake ~/.config/nix-darwin
```

3. Next time just rebuild it

```sh
darwin-rebuild switch --flake ~/.config/nix-darwin/flake.nix
```
