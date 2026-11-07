{ config, pkgs, inputs, ...}:

 ## EXTRA PACKAGES
 let
  artcraft = inputs.artcraft.packages.${pkgs.stdenv.hostPlatform.system};
 in

{
 ## ENABLE PROGRAMS
 programs.steam.enable = true;
 programs.firefox.enable = false;
 programs.kde-pim.enable = false;
 programs.nix-ld.enable = true;
 programs.ccache.enable = true;

 ## COMPATABILITY
 programs.nix-ld.libraries = with pkgs; [];
 programs.appimage = {
  enable = true;
  binfmt = true;
 };

 ## SYSTEM PACKAGES
 environment.systemPackages = [
   pkgs.fastfetch
   pkgs.unrar
   pkgs.htop
   pkgs.ncdu
   pkgs.ghc
   pkgs.rustup
   pkgs.gcc
   pkgs.pkg-config
   pkgs.python3
   pkgs.zenity
   pkgs.wineWow64Packages.stable
   pkgs.winetricks
   pkgs.opencode-desktop
   pkgs.icoutils
   pkgs.p7zip
   artcraft.default
   pkgs.cabextract
   pkgs.kdePackages.kde-cli-tools
   pkgs.git
   pkgs.nil
   pkgs.stockfish
   pkgs.lc0
   pkgs.gnuchess
   pkgs.ghidra
   pkgs.pychess
   pkgs.aria2
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
   freetube
   sc-controller
   protonplus
   papirus-icon-theme
   inputs.mocktail.packages.${pkgs.system}.default
 ];

 ## EXCLUDE PACKAGES
 environment.plasma6.excludePackages = with pkgs.kdePackages; [
   qrca
   elisa
   kwalletmanager
 ];
}
