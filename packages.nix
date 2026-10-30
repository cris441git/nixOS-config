{ config, pkgs, inputs, ...}:

{
 programs.steam.enable = true;
 programs.firefox.enable = false;
 programs.kde-pim.enable = false;

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

 users.users.cris441.packages = with pkgs;  [
   vesktop
   lutris
   krita
   obs-studio
   zapzap
   vlc
   vinegar
   rpi-imager
   ungoogled-chromium
   vscodium
   gamescope
   sc-controller
   protonplus
   papirus-icon-theme
   inputs.mocktail.packages.${pkgs.system}.default
 ];

 environment.plasma6.excludePackages = with pkgs.kdePackages; [
   okular
   qrca
   elisa
   kwalletmanager
 ];
}
