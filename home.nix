{
  config,
  pkgs,
  lib,
  extra,
  ...
}:
let
  symlink = path: config.lib.file.mkOutOfStoreSymlink "/home/${extra.user}/.dotfiles/${path}";
in
{
  nixpkgs.config.allowUnfree = true;

  home.username = "${extra.user}";
  home.homeDirectory = "/home/${extra.user}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  xdg.configFile = {
    "nvim".source = symlink "nvim";
    # "hypr".source = symlink "hypr";
    "ghostty".source = symlink "ghostty";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    just
    ripgrep # "rg" cli, alternative to grep, used by nvim
    fd # find alternative, used by nvim
    lsd # "ls" alternative
    zoxide # "z" command
    gh # GitHub CLI
    jujutsu
    devenv
    devbox
    tldr
    biome
    dive
    nodejs_24

    # LSP Executables
    nixd
    nixfmt-rfc-style
    efm-langserver # Generic language server
    lua-language-server # Lua lsp
    gopls # Go lsp
    shellcheck
    nodePackages.intelephense # PHP lsp
    nodePackages.typescript-language-server
    nodePackages.svelte-language-server
    nodePackages.bash-language-server
    prettierd
    eslint_d
    zls
  ];

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    includes = [
      {
        contents = {
          init.defaultBranch = "main";
          pull.rebase = true;
        };
      }
    ];
  };

  programs.fish = {
    enable = true;
    shellInit = lib.strings.concatStringsSep "\n" (
      [
        (builtins.readFile ./fish/config.fish)
      ]
      ++ lib.attrsets.mapAttrsToList (name: value: builtins.readFile (./fish/functions + ("/" + name))) (
        builtins.readDir ./fish/functions
      )
    );
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      enter_accept = false;
      inline_height = 15;
      style = "compact";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
