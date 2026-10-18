{ config, pkgs, ...}:

{
 programs.steam.enable = true;
 programs.firefox.enable = true;
 
 environment.systemPackages = with pkgs;  [
   fastfetch
   unrar
   labwc
   htop
   ncdu
   gpaste
   aria2
 ];

 users.users.cris441.packages = with pkgs;  [
   vesktop
   rewaita
   lutris
   gamescope
   sc-controller
   protonplus
   papirus-icon-theme
 ];
}
