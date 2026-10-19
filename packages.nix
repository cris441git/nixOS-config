{ config, pkgs, ...}:

{
 programs.steam.enable = true;
 programs.firefox.enable = true;

 environment.systemPackages = with pkgs;  [
   fastfetch
   unrar
   htop
   ncdu
   aria2
 ];

 users.users.cris441.packages = with pkgs;  [
   vesktop
   lutris
   kdePackages.plasma-browser-intergration
   kdePackages.kate # install only for user
   gamescope
   sc-controller
   protonplus
   papirus-icon-theme
 ];

 environment.plasma6.excludePackages = with pkgs.kdePackages; [
   kmail
   ktnef
   gwenview
   okular
   kontact
   qrca
   kate
   akonadi
   elisa
   kwalletmanager
 ];
}
