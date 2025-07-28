{ config, unstable, pkgs, lib, ... } @ args:
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-public-keys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
    substituters = [
      "https://cache.iog.io"
    ];
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
    plymouth = {
      enable = true;
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  programs = {
    hyprland.enable = true;
    thunar.enable = true;
    xfconf.enable = true;
    amnezia-vpn = {
      enable = true;
      package = pkgs.amnezia-vpn;
    };
    iio-hyprland.enable = true;
    zsh = {
      shellAliases = {
        rebuild-nixos = "sudo nixos-rebuild switch --flake ~/.config/nixos";
        rebuild-nixos-upgrade = "sudo nixos-rebuild switch --flake ~/.config/nixos --upgrade";
        nixos-config = "code ~/.config/nixos/";
      };
      enable = true;
    };
    virt-manager.enable = true;
  };

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
    displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        border_fg = "0x0007";
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  imports = [
    ./hardware-configuration.nix
    (import ./home/stylix.nix { inherit config pkgs unstable; })
  ];

  users.users.nikkotanns.shell = pkgs.zsh;

  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      GTK_THEME = "Blackout";
      RUST_SRC_PATH = "${unstable.rust.packages.stable.rustPlatform.rustLibSrc}";
      XDG_DATA_DIRS = [ (pkgs.glib.getSchemaDataDirPath pkgs.gsettings-desktop-schemas) ];
    };

    variables = {
      RUST_SRC_PATH = "${unstable.rust.packages.stable.rustPlatform.rustLibSrc}";
      GTK_THEME = "Blackout";
    };
  };

  fonts = {
    enableDefaultPackages = true;
    packages = [
      pkgs.nerd-fonts.jetbrains-mono
    ];
  };

  hardware = {
    sensor.iio.enable = true;
    trackpoint = {
      sensitivity = 100;
      speed = 60;
    };
    bluetooth.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-ocl
      ];
    };
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    libvirtd.enable = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Moscow";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };

  users.users.nikkotanns = {
    isNormalUser = true;
    description = "nikkotanns";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "render" "libvirtd" ];
    packages = [ ];
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
