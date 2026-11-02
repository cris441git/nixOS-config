{ ... }:

{
 ## OVERLAYS
 nixpkgs.overlays = [ (import ../pkgs) ];
}
