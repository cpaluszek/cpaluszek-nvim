{inputs}: let
  inherit (inputs.nixpkgs) legacyPackages;
in rec {
  mkVimPlugin = {system}: let
    inherit (pkgs) vimUtils;
    inherit (vimUtils) buildVimPlugin;
    pkgs = legacyPackages.${system};
  in
    buildVimPlugin {
      dependencies = with pkgs.vimPlugins; [
        # Theme
        tokyonight-nvim
        gruvbox-nvim

        # Languages

        # Navigation
        telescope-nvim

        # Extras
        lualine-nvim
        gitsigns-nvim
        comment-nvim
      ];

      name = "cpaluszek";

      # Clean up unnecessary files after installation.
      postInstall = ''
        rm -rf $out/.gitignore
        rm -rf $out/flake.nix
        rm -rf $out/flake.lock
        rm -rf $out/lib
        rm -rf $out/justfile
      '';

      src = ../.;
    };

  mkNeovimPlugins = {system}: let
    inherit (pkgs) vimPlugins vimExtraPlugins;
    pkgs = legacyPackages.${system};
    cpaluszek-nvim = mkVimPlugin { inherit system; }; # Points to the plugin built by mkVimPlugin
  in
    [
      vimPlugins.trouble-nvim

      vimExtraPlugins.themery-nvim

      # configuration
      vimPlugins.cpaluszek-nvim
    ];

  mkExtraPackages = {system}: let
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in [
    # language servers
    pkgs.lua-language-server
    # pkgs.gopls

    # formatters
    # pkgs.gofumpt
    # pkgs.golines
  ];

  mkExtraConfig = ''
    lua << EOF
      require 'cpaluszek'.init()
    EOF
  '';

  mkNeovim = {system}: let
    inherit (pkgs) lib neovim;
    extraPackages = mkExtraPackages { inherit system; };
    pkgs = legacyPackages.${system};
    start = mkNeovimPlugins { inherit system; };
  in
    neovim.override {
      configure = {
        customRC = mkExtraConfig;
        packages.main = { inherit start; };
      };
      extraMakeWrapperArgs = ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
    };

  mkHomeManager = {system}: let
    extraConfig = mkExtraConfig;
    extraPackages = mkExtraPackages { inherit system; };
    plugins = mkNeovimPlugins { inherit system; };
  in {
    inherit extraConfig extraPackages plugins;
    defaultEditor = true;
    enable = true;
  };
}
