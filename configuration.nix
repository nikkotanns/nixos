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
    trusted-substituters = [
      "https://cache.iog.io"
    ];
    trusted-users = [ "root" "nikkotanns" ];
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
        dv = ''export DIRENV_LOG_FORMAT=""; direnv exec .'';
      };
      enable = true;
    };
    virt-manager.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        gcc-unwrapped
      ];
    };
  };

  services = {
    v2raya.enable = true;
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
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-ocl
      ];
    };
  };

  virtualisation = {
    containers.enable = true;
    oci-containers.backend = "docker";
    docker = {
      enable = true;
      package = unstable.docker;
      storageDriver = "btrfs";
      daemon.settings = {
        dns = [ "8.8.8.8" "1.1.1.1" ];
      };
    };
  };

  # Win 11 VM
  virtualisation.oci-containers.containers."win-box" = {
    image = "dockurr/windows";
    autoStart = false;
    environment = {
      VERSION = "win11";
      RAM_SIZE = "8G";
      CPU_CORES = "4";
      DISK_SIZE = "64G";
    };
    volumes = [
      "/var/lib/win11-data:/storage"
      "${./autounattend.xml}:/custom.xml"
    ];
    extraOptions = [
      "--device=/dev/kvm"
      "--cap-add=NET_ADMIN"
    ];
    ports = [
      "8006:8006"
      "3389:3389"
    ];
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
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "render" ];
    packages = [ ];
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
