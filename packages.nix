{ config, pkgs, inputs, ...}:

{
 ## ENABLE PROGRAMS
 programs.steam.enable = true;
 programs.firefox.enable = false;
 programs.kde-pim.enable = false;

 programs.nix-ld.enable = true;
 programs.nix-ld.libraries = with pkgs; [];

 ## SYSTEM PACKAGES
 environment.systemPackages = with pkgs;  [
   fastfetch
   unrar
   htop
   ncdu
   gcc
   kdePackages.kde-cli-tools
   git
   nil
   aria2
 ];

 ## USER PACKAGES
 users.users.cris441.packages = with pkgs;  [
   vesktop
   lutris
   krita
   obs-studio
   zapzap
   vlc
   spotdl
   theclicker
   audacious
   vinegar
   rpi-imager
   chromium
   (chromium.override { enableWideVine = true; })
   vscodium
   gamescope
   sc-controller
   protonplus
   papirus-icon-theme
   inputs.mocktail.packages.${pkgs.system}.default
 ];

 ## EXCLUDE PACKAGES
 environment.plasma6.excludePackages = with pkgs.kdePackages; [
   okular
   qrca
   elisa
   kwalletmanager
 ];

 ## OVERLAY
 nixpkgs.overlays = [
  (final: prev: {
    audacious-plugins = prev.audacious-plugins.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        install -Dm755 ${./audacious-plugins/discord-rpc.so} \
          $out/lib/audacious/General/discord-rpc.so
      '';
    });
  })
 ];
 
}
