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
          })
          inputs.neovim-nightly-overlay.overlays.default
        ];
        hosts = builtins.attrNames (builtins.readDir ./hosts);

        # Build a home configuration; host = null means the default, which
        # skips the per-host override module.
        mkHomeConfiguration =
          host:
          let
            hostModule = nixpkgs.lib.optional (host != null) ./hosts/${host}/home.nix;
          in
          {
            name = if host == null then user else "${user}@${host}";
            value = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;

              modules = [
                { nixpkgs.overlays = overlays; }
                ./home.nix
              ]
              ++ hostModule;

              extraSpecialArgs = {
                extra = {
                  inherit user dotfilesHome host;
                };
              };
            };
          };
      in
      {
        formatter = pkgs.nixfmt-rfc-style;

        packages.homeConfigurations = builtins.listToAttrs (
          (map mkHomeConfiguration hosts) ++ [ (mkHomeConfiguration null) ]
        );
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
