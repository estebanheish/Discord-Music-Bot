{
  description = "simple python flake";

  inputs = {nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";};

  outputs = {
    self,
    nixpkgs,
  }: let
    allSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

    forAllSystems = fn:
      nixpkgs.lib.genAttrs allSystems
      (system: fn {pkgs = import nixpkgs {inherit system;};});

    deps = ps:
      with ps; [
        discordpy
        pynacl
        yt-dlp
        validators
      ];
  in {
    devShells = forAllSystems ({pkgs}: {
      default = pkgs.mkShell {
        name = "nix";
        packages = with pkgs; [
          pyright
          black
          (python3.withPackages deps)
        ];
      };
    });
    packages = forAllSystems ({pkgs}: {
      default = pkgs.python3Packages.buildPythonApplication {
        pname = "slavibot";
        version = "0.0.1";

        src = ./.;

        dependencies = with pkgs;
          [
            ffmpeg
          ]
          ++ (deps python3Packages);
      };
    });
  };
}
