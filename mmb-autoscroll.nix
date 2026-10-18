# NixOS module: mmb-autoscroll — Windows-style middle-button autoscroll
# (evdev grab -> uinput) for Wayland.
#
# Usage (configuration.nix):
#
#   imports = [ ./mmb-autoscroll/mmb-autoscroll.nix ];
#
#   services.mmb-autoscroll = {
#     enable = true;
#     settings = {
#       MMB_MODE = "rate";
#       MMB_DEADZONE = 18;
#       MMB_GAIN = 0.020;
#       MMB_HORIZONTAL = true;
#     };
#   };
#
# mmb_autoscroll.py must sit next to this file (it is used unmodified).
{ config, lib, pkgs, ... }:

let
  cfg = config.services.mmb-autoscroll;

  python = pkgs.python3.withPackages (ps: [ ps.evdev ]);

  # Copy the script into the store so it is always the exact file next to this module.
  script = pkgs.writeText "mmb_autoscroll.py" (builtins.readFile ./mmb_autoscroll.py);

  # Env values must be strings; bools become 1/0 (the script uses int flags).
  toEnv = v:
    if builtins.isBool v then (if v then "1" else "0")
    else toString v;
in
{
  options.services.mmb-autoscroll = {
    enable = lib.mkEnableOption "mmb-autoscroll, Windows-style middle-button autoscroll for Wayland";

    settings = lib.mkOption {
      type = with lib.types; attrsOf (oneOf [ str int float bool ]);
      default = { };
      example = lib.literalExpression ''
        {
          MMB_MODE = "rate";
          MMB_DEADZONE = 18;
          MMB_GAIN = 0.020;
          MMB_EXPONENT = 1.30;
          MMB_MAX_SPEED = 40;
          MMB_TICK_MS = 15;
          MMB_HORIZONTAL = true;
          MMB_INVERT_V = false;
          MMB_INVERT_H = false;
          MMB_MATCH_NAME = "(?i)mouse";
        }
      '';
      description = ''
        Tunables passed to the service as environment variables (MMB_*).
        Anything not set falls back to the script's built-in default.
        See the comments in the original mmb-autoscroll.conf sample for what each does:
        MMB_MODE, MMB_DEADZONE, MMB_GAIN, MMB_EXPONENT, MMB_MAX_SPEED, MMB_TICK_MS,
        MMB_POSITION_FACTOR, MMB_HORIZONTAL, MMB_INVERT_V, MMB_INVERT_H,
        MMB_MATCH_NAME, MMB_DEVICE, MMB_UINPUT_NAME.
      '';
    };

    environmentFile = lib.mkOption {
      type = with lib.types; nullOr path;
      default = null;
      example = "/etc/mmb-autoscroll.conf";
      description = ''
        Optional runtime file in systemd EnvironmentFile syntax (KEY=VALUE), so you can
        retune with `systemctl restart mmb-autoscroll` without a rebuild. Values here
        override <option>settings</option>. A missing file is ignored.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # /dev/uinput must exist for the virtual pointer.
    boot.kernelModules = [ "uinput" ];

    systemd.services.mmb-autoscroll = {
      description = "mmb-autoscroll — Windows-style middle-button autoscroll (evdev grab -> uinput)";
      documentation = [ "https://wayland.freedesktop.org/libinput/doc/latest/scrolling.html" ];
      wantedBy = [ "multi-user.target" ];
      after = [ "systemd-udevd.service" ];
      wants = [ "systemd-udevd.service" ];

      # Rate limiting belongs in [Unit]; keep it off so a real crash can't cause a lockout.
      unitConfig.StartLimitIntervalSec = 0;

      environment = lib.mapAttrs (_: toEnv) cfg.settings;

      serviceConfig = {
        Type = "simple";
        # Leading "-" = ignore if the file is missing.
        EnvironmentFile = lib.optional (cfg.environmentFile != null) "-${toString cfg.environmentFile}";
        ExecStart = "${python}/bin/python3 ${script}";
        Restart = "always";
        RestartSec = 2;

        # --- hardening: only the input subsystem + the uinput node ---
        DevicePolicy = "closed";
        DeviceAllow = [ "/dev/uinput rw" "char-input rw" ];
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        ProtectControlGroups = true;
        ProtectKernelTunables = true;
        RestrictAddressFamilies = "AF_UNIX";
        NoNewPrivileges = true;
      };
    };
  };
}
