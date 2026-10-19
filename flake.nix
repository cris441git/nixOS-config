{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.mocktail.url = "github:komaruworld/mocktail";

  outputs = { self, nixpkgs, mocktail, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs; };
        modules = [
           ./configuration.nix
           ./packages.nix
        ];
      };
    };
  };
}
