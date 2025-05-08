{
  description = "Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixneovimplugins.url = "github:NixNeovim/NixNeovimPlugins";
  };

  outputs = { self, nixpkgs, nixneovimplugins }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nixneovimplugins.overlays.default ];
      };
    in {
      lib = import ./lib {
        inputs = self.inputs;
        inherit pkgs;
      };

      packages.${system} = {
        default = self.lib.mkVimPlugin { inherit system; };
        neovim = self.lib.mkNeovim { inherit system; };
      };

      apps.${system} = {
        nvim = {
          program = "${self.packages.${system}.neovim}/bin/nvim";
          type = "app";
        };
      };

      devShells.${system} = {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          buildInputs = [ nixpkgs.legacyPackages.${system}.just ];
        };
      };
    };
}
