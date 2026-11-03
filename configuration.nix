{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./imports/hardening.nix
      ./imports/packages.nix
      ./imports/custom-pkgs.nix
      inputs.open-historia.nixosModules.default
    ];

  ## NIX OPTIONS
  nix.settings.experimental-features = [ "flakes" "nix-command" ];
  nixpkgs.config = {
  problems.handlers = {
    "gtk+".broken = "warn"; ## Lutris is still requiring gtk2 for some reason
  };
};
   
  ## HARDWARE, BOOT AND KERNEL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.new_feature;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  ## NETWORKING
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.extraHosts = "127.0.0.1 weechat.local";
 
  ## LOCALES
  time.timeZone = "Europe/Lisbon";

  i18n.defaultLocale = "pt_PT.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  ## SERVICES AND SYSTEM CONFIGURATION
  services.xserver.enable = false;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "pt";
    variant = "";
  };

  console.keyMap = "pt-latin1";

  services.printing.enable = false;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  services.weechat = {
    enable = true;
  };

  programs.screen.screenrc = ''
    multiuser on
    acladd cris441 
    term screen-256color
  '';

  services.ollama = {
  enable = true;
  package = pkgs.ollama-cuda;
  host = "127.0.0.1";
  port = 11434;
  environmentVariables = {
    OLLAMA_ORIGINS = "http://localhost:3000,http://127.0.0.1:3000";
  };
 };

 services.open-historia.enable = true;

  ## USER ACCOUNTS
  users.users."cris441" = {
    isNormalUser = true;
    description = "cris441";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" ];
  };

  ## UNFREE REPOSITORY
  nixpkgs.config.allowUnfree = true;

  ## MISC
  system.stateVersion = "26.05";

}
