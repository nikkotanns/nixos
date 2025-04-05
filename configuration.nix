{ config, unstable, pkgs, lib, ... } @ args:
{


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      border_fg = "0x0007";
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  systemd.services.myCommand = {
    description = "Run amnezia vpn service";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        AmneziaVPN-service
      '';
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot = {
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
      logo = ./logo.png;
    };
  };
  stylix.targets.plymouth.enable = false;


  programs.hyprland.enable = true;
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  programs.iio-hyprland.enable = true;
  hardware.sensor.iio.enable = true;

  imports = [
    ./hardware-configuration.nix
    (import ./stylix.nix { inherit config pkgs unstable; })
  ];

  users.users.nikkotanns.shell = pkgs.zsh;
  programs.zsh = {
    shellAliases = {
      rebuild-nixos = "sudo nixos-rebuild switch --flake ~/.config/nixos";
      rebuild-nixos-upgrade = "sudo nixos-rebuild switch --flake ~/.config/nixos --upgrade";
      nixos-config = "code ~/.config/nixos/";
    };
    enable = true;
  };


  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    GTK_THEME = "Blackout";
  };

  hardware.trackpoint = {
    sensitivity = 80;
    speed = 120;
  };

  environment.sessionVariables = {
    RUST_SRC_PATH = "${unstable.rust.packages.stable.rustPlatform.rustLibSrc}";
    XDG_DATA_DIRS = [ (pkgs.glib.getSchemaDataDirPath pkgs.gsettings-desktop-schemas) ];
  };

  environment.variables = {
    RUST_SRC_PATH = "${unstable.rust.packages.stable.rustPlatform.rustLibSrc}";
    GTK_THEME = "Blackout";
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })
    ];
  };


  hardware.bluetooth.enable = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-ocl
    ];
  };

  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define your hostname.
  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nikkotanns = {
    isNormalUser = true;
    description = "nikkotanns";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "render" ];
    packages = [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
