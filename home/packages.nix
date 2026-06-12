{ pkgs, unstable, inputs, ... }: {
  home.packages = with pkgs; [

    # Desktop
    libnotify
    rofi
    blueman
    networkmanagerapplet
    capitaine-cursors
    hyprpolkitagent
    brightnessctl
    hyprshot
    wl-clipboard

    fastfetch

    coreutils
    busybox
    file

    jq

    bottom
    btop
    dust
    tokei
    ripgrep
    eza
    erdtree

    gh

    unstable.vscode

    clang

    # Rust
    unstable.rustc
    unstable.cargo
    unstable.rustfmt
    unstable.rust-analyzer

    # Lean 4
    unstable.elan

    # Typst
    unstable.typst
    unstable.typstyle
    unstable.typstyle
    unstable.typst-live
    unstable.typstwriter
    unstable.tinymist

    # Obsidian
    unstable.obsidian

    # OpenCL
    clinfo
    khronos-ocl-icd-loader

    # Nix language
    nil
    nixpkgs-fmt
    inputs.nix-alien.packages.${stdenv.hostPlatform.system}.nix-alien # Nix alien

    gcc

    # Proxy
    unstable.xray
    amnezia-vpn
    amneziawg-go
    amneziawg-tools

    # BitTorrent client
    transmission_4-qt

    # Video player
    vlc

    # Games
    chocolate-doom
    inputs.self.packages.x86_64-linux.prismlauncher-appimage

    appimage-run

    # Libs
    alsa-lib
    udev
    pkg-config
    libX11
    glib
  ];
}
