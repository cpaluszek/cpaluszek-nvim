{inputs, pkgs}:
rec {
  mkVimPlugin = {system}: let
    inherit (pkgs) vimUtils;
    inherit (vimUtils) buildVimPlugin;
  in
    buildVimPlugin {
      dependencies = with pkgs.vimPlugins; [
        # Theme
        tokyonight-nvim
        gruvbox-nvim
        catppuccin-nvim

        # Languages
        nvim-lspconfig
        nvim-treesitter.withAllGrammars

        # Completions
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmo-cmdline
        luasnip

        # Navigation
        telescope-nvim
        trouble-nvim
        vim-tmux-navigator

        # Extras
        lualine-nvim
        gitsigns-nvim
        comment-nvim
        which-key-nvim
        render-markdown-nvim
        nvim-notify
        mini-pairs
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
    inherit (pkgs) vimPlugins;
    cpaluszek-nvim = mkVimPlugin { inherit system; }; # Points to the plugin built by mkVimPlugin
  in
    [
      vimPlugins.nvim-web-devicons

      pkgs.vimExtraPlugins.themery-nvim

      # configuration
      cpaluszek-nvim
    ];

  mkExtraPackages = {system}: let
    pkgsWithConfig = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in [
    # language servers
    pkgsWithConfig.lua-language-server
    pkgsWithConfig.nil
    # pkgs.gopls

    # formatters
    pkgsWithConfig.alejandra
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
