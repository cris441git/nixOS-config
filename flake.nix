{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.mocktail.url = "github:komaruworld/mocktail";
  inputs.open-historia.url = "github:Open-Historia/open-historia";

  outputs = { self, nixpkgs, mocktail, open-historia, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs; };
        modules = [
           ./configuration.nix
           ./imports/packages.nix
           ./imports/custom-pkgs.nix
        ];
      };
    };
  };
}
