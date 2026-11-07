{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
  inputs.mocktail.url = "github:komaruworld/mocktail";
  inputs.open-historia.url = "github:Open-Historia/open-historia";
  inputs.artcraft.url = "github:Hy4ri/artcraft-flake";

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
