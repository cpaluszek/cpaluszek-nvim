{
  description = "Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
    in {
      lib = import ./lib {inputs = self.inputs; };

      packages = {
        default = self.lib.mkVimPlugin { inherit system; };
        neovim = self.lib.mkNeovim { inherit system; };
      };

      apps = {
        nvim = {
          program = "${self.packages.${system}.neovim}/bin/nvim";
          type = "app";
        };
      };
  };
}
