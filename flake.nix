{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... }@inputs:
  let
    system = "x86_64-linux";
    stateVersion = "25.11";
    user = "mitchanx";
    hostname = "homelab";
  in
  {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = { inherit inputs stateVersion user hostname; };
      modules = [
        ./configuration.nix
        disko.nixosModules.disko
      ];
    };
  };
}
