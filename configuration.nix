{ config, unstable, pkgs, lib, inputs, ... } @ args:
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "nikkotanns" ];
    substituters = [
      "https://cache.nixos.org"
    ];
    require-sigs = false;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages;
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"

      "nouveau.modeset=0"
      "module_blacklist=nouveau"
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
      
      "usbcore.autosuspend=-1"
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
    dconf.enable = true;
    iio-hyprland.enable = true;
    zsh = {
      shellAliases = {
        rebuild-nixos = "sudo nixos-rebuild switch --flake ~/.config/nixos";
        nixos-config = "code ~/.config/nixos/";
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
  environment.systemPackages = with pkgs; [
    cacert
  ];

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
    hardware.bolt.enable = true;
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
      GTK_THEME = "Sweet-Dark";
      RUST_SRC_PATH = "${unstable.rust.packages.stable.rustPlatform.rustLibSrc}";
    };

    variables = {
      RUST_SRC_PATH = "${unstable.rust.packages.stable.rustPlatform.rustLibSrc}";
      GTK_THEME = "Sweet-Dark";
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
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


  boot.blacklistedKernelModules = [ "nouveau" "nvidiafb" ];

  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';

  # 4. Поддержка Thunderbolt и авторизация eGPU

  # 5. Графика и видеодрайвер
  hardware.graphics = {
    enable32Bit = true;
  };

  # Укажите драйвер встроенной карты (intel/modesetting или amdgpu) вместе с nvidia
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  hardware.nvidia = {
    # Режим KMS
    modesetting.enable = true;

    # СТРОГО ОБЯЗАТЕЛЬНО ДЛЯ BLACKWELL (RTX 50xx):
    open = true;

    # Отключение глубокого сна во избежание зависаний туннеля Thunderbolt
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    nvidiaSettings = true;

    # Выбор актуального пакета драйверов (ветка 570+)
    package = config.boot.kernelPackages.nvidiaPackages.production;

    # Разрешение внешней видеокарты для PRIME-вычислений/рендеринга
    prime = {
      allowExternalGpu = true;
      # Если требуется PRIME offload, раскомментируйте и укажите Bus ID:
      # offload.enable = true;
      # offload.enableOffloadCmd = true;
      # intelBusId = "PCI:0:2:0";   # Значение из lspci в десятичном формате
      # nvidiaBusId = "PCI:x:0:0";  # Bus ID вашей eGPU
    };
  };
}
