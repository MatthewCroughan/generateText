{
  description = "A bad idea";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      imports = [
        flake-parts.flakeModules.easyOverlay
      ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          overlays = [
            inputs.self.overlays.default
          ];
          inherit system;
        };
        overlayAttrs = config.legacyPackages;
        packages = rec {
          hello-llm = pkgs.writeCBin "hello-llm" (builtins.readFile hello-llm-sources);
          hello-llm-sources = pkgs.generateText { prompt = "// Below is hello world in C\n"; seed = 2;};
          hello-banana = pkgs.writeCBin "hello-banana" (builtins.readFile hello-banana-sources);
          hello-banana-sources = pkgs.generateText { prompt = "// Below is  hello world in C, but 'world' is replaced with 'banana'\n"; seed = 1;};
        };
        legacyPackages = {
          generateText = pkgs.callPackage ./generateText.nix {};
        };
      };
    };
}
