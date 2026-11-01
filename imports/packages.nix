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
   python3
   wineWow64Packages.stable
   winetricks
   zenity
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
   vesktop
   lutris
   krita
   obs-studio
   zapzap
   vlc
   spotdl
   gajim
   glowing-bear
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
    audacious-discord-rpc = final.stdenv.mkDerivation {
      pname = "audacious-discord-rpc";
      version = "prebuilt";
      src = ./audacious-plugins/discord-rpc.so;
      dontUnpack = true;
      nativeBuildInputs = [ final.autoPatchelfHook ];
      buildInputs = [
        final.audacious-bare
        final.curl
        final.stdenv.cc.cc.lib
      ];
      installPhase = ''
        install -Dm755 $src $out/lib/audacious/General/discord-rpc.so
      '';
    };

    audacious-plugins = prev.audacious-plugins.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        install -Dm755 ${final.audacious-discord-rpc}/lib/audacious/General/discord-rpc.so \
          $out/lib/audacious/General/discord-rpc.so
      '';
    });
  })
 ];
 
}
