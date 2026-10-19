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
   gamescope
   sc-controller
   protonplus
   papirus-icon-theme
 ];
}
