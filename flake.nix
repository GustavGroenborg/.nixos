{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { inherit system; };
    in
      {
        nixosConfigurations = {
          nixos = nixpkgs.lib.nixosSystem {
            modules = [
              ./configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs   = true;
                home-manager.useUserPackages = true;
                
                home-manager.users.gcrg = import ./home.nix;
              }
            ];
          };
        };
        devShells.${system} = {
          haskell = import ./shells/haskell.nix { inherit pkgs; };
          java25  = import ./shells/java.nix {
            inherit pkgs;
            jdk = pkgs.jdk25_headless;
          };
        };
      };
}
