{config, pkgs, ... }:

{

  boot.kernel.sysctl = {
    "kernel.dmesg_restrict" = 1;
    "kernel.kptr_restrict" = 2;
    "vm.mmap_rnd_bits" = 32;
    "kernel.unprivileged_bpf_disabled" = 1;
    "fs.protected_symlinks" = 1;
    "fs.protected_hardlinks" = 1;
  };

  services.openssh.enable = false; # i dont use openssh, so this is just another attack surface asking to popped open, so ill turn it off

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  
  nix.settings.auto-optimise-store = true;

}
