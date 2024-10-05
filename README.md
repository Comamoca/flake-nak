<div align="center">

![Last commit](https://img.shields.io/github/last-commit/Comamoca/flake-nak?style=flat-square)
![Repository Stars](https://img.shields.io/github/stars/Comamoca/flake-nak?style=flat-square)
![Issues](https://img.shields.io/github/issues/Comamoca/flake-nak?style=flat-square)
![Open Issues](https://img.shields.io/github/issues-raw/Comamoca/flake-nak?style=flat-square)
![Bug Issues](https://img.shields.io/github/issues/Comamoca/flake-nak/bug?style=flat-square)

<img src="https://emoji2svg.deno.dev/api/🦊" alt="eyecatch" height="100">

# flake-nak

Nix flake support for [nak](https://github.com/fiatjaf/nak). 

<br>
<br>


</div>

<div align="center">

</div>

## 🚀 How to use

### nix run

```sh
nix run github:comamoca/flake-nak
```

### Overlay

Add to this package to nixpkgs via Nix overlay.

```nix
nixpkgs.overlays = overlays ++ [
  (final: prev: {
    nak = inputs.nak.packages.${system}.default;
  })
];
```

## ⛏️   Development

```sh
# build
nix build

# format
nix fmt
```
## 📜 License

zlib

### 🧩 Modules

- [flake-parts](https://flake.parts/)
- [Comamoca/scaffold](https://github.com/comamoca/scaffold)  
  Based on this repository `flake-basic` template.

## 💕 Special Thanks

- [nak](https://github.com/fiatjaf/nak)
