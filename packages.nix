{ config, pkgs, ...}:

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
   gamescope
   sc-controller
   protonplus
   papirus-icon-theme
 ];

 environment.plasma6.excludePackages = with pkgs.kdePackages; [
   gwenview
   okular
   qrca
   elisa
   kwalletmanager
 ];
}
