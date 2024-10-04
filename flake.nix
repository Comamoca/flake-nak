{
  description = "a command line tool for doing all things nostr";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs@{
      self,
      systems,
      nixpkgs,
      treefmt-nix,
      flake-parts,
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        treefmt-nix.flakeModule
        inputs.flake-parts.flakeModules.easyOverlay
      ];
      systems = import inputs.systems;

      perSystem =
        {
          config,
          pkgs,
          system,
          final,
          ...
        }:
        let
          stdenv = pkgs.stdenv;
          version = "0.7.6";

          overlayAttrs = {
            inherit (config.packages) nak;
          };

          nak = pkgs.buildGo123Module rec {
            name = "nak";
            src = pkgs.fetchFromGitHub {
              owner = "fiatjaf";
              repo = "nak";
              rev = "2988c71ccba5a5a7028e36cd5d6032d95b0dfb53";
              sha256 = "1asfz73v54zgxm6qqscvrc2di1chk0261pw2v7ry0v3ir5qv1nqb";
            };
            buildInputs = [ pkgs.go ];
            vendorHash = "sha256-zPRNkNv4m+2Q7hknLewj7IUSN5UUqfczbRW6s2rI5/0=";
            doCheck = false;
          };

          executable = stdenv.mkDerivation {
            pname = "nak";
            src = nak;
            version = "v${version}";

            installPhase = ''
              install -D ./bin/nak $out/bin/nak
            '';
          };
        in
        rec {
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
            };

            settings.formatter = { };
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              nil
            ];
          };

          packages.default = executable;
          packages.nak = executable;
        };
    };
}
