{ config, pkgs, inputs, ...}:

{
 ## ENABLE PROGRAMS
 programs.steam.enable = true;
 programs.firefox.enable = false;
 programs.kde-pim.enable = false;
 programs.nix-ld.enable = true;
 programs.ccache.enable = true;
 programs.nix-ld.libraries = with pkgs; [];

 ## SYSTEM PACKAGES
 environment.systemPackages = with pkgs;  [
   fastfetch
   unrar
   htop
   ncdu
   ghc
   rustup
   gcc
   pkg-config
   python3
   zenity
   wineWow64Packages.stable
   winetricks
   #opencode-desktop
   icoutils
   p7zip
   cabextract
   kdePackages.kde-cli-tools
   git
   nil
   aria2
 ];

 ## USER PACKAGES
 users.users.cris441.packages = with pkgs;  [
   (chromium.override { enableWideVine = true; })
   vesktop
   lutris
   krita
   obs-studio
   zapzap
   vlc
   spotdl
   gajim
   weechat
   theclicker
   audacious
   vinegar
   rpi-imager
   chromium
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
}
