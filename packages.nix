{ config, pkgs, inputs, ...}:

{
 programs.steam.enable = true;
 programs.firefox.enable = true;
 programs.kde-pim.enable = false;

 environment.systemPackages = with pkgs;  [
   fastfetch
   unrar
   htop
   ncdu
   git
   nil
   aria2
 ];

 users.users.cris441.packages = with pkgs;  [
   vesktop
   lutris
   krita
   obs-studio
   zapzap
   vlc
   vinegar
   rpi-imager
   vscodium
   gamescope
   sc-controller
   protonplus
   papirus-icon-theme
   inputs.mocktail.packages.${pkgs.system}.default
 ];

 environment.plasma6.excludePackages = with pkgs.kdePackages; [
   gwenview
   okular
   qrca
   elisa
   kwalletmanager
 ];
}
