{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { inherit system; };
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
      {
        nixosConfigurations = {
          t480 = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./hosts/t480/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs   = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = { inherit pkgs-unstable; };
              }
            ];
          };
          desktop = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./hosts/desktop/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs   = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = { inherit pkgs-unstable; };
              }
            ];
          };
        };

        devShells.${system} = {
          cc-tools = import ./shells/cc-tools.nix { inherit pkgs; };
          haskell = import ./shells/haskell.nix { inherit pkgs; };
          java25  = import ./shells/java.nix {
            inherit pkgs;
            jdk = pkgs.jdk25_headless;
          };
        };
      };
}
