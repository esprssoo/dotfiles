{
  description = "Home Manager configuration";

  inputs = {
    disko.url = "github:nix-community/disko";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devbox.url = "github:jetify-com/devbox/latest";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      disko,
      nixpkgs,
      home-manager,
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        user = "nikos"; # change your user here
        dotfilesHome = "/home/${user}/.dotfiles"; # specify your dotfiles path
        pkgs = nixpkgs.legacyPackages.${system};
        overlays = [
          (self: super: {
            devbox = inputs.devbox.packages.${system}.default;
            # lexical = pkgs.lexical.override {
            #   elixir = pkgs.elixir_1_17;
            # };
          })
          inputs.neovim-nightly-overlay.overlays.default
        ];
      in
      {
        formatter = pkgs.nixfmt-rfc-style;

        packages.homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            { nixpkgs.overlays = overlays; }
            ./home.nix
          ];

          extraSpecialArgs = {
            extra = { inherit user dotfilesHome; };
          };
        };
      }
    )
    // {
      nixosConfigurations.melinoe = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.disko.nixosModules.disko
          ./nixos/melinoe/configuration.nix
        ];
      };
    };
}
