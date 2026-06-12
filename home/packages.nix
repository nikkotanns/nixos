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

    # GAP – A System for Computational Discrete Algebra
    gap

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

    # Python
    python313

    gcc

    # Javascript
    unstable.bun

    # Golang
    go

    # Proxy
    unstable.xray
    amnezia-vpn
    amneziawg-go
    amneziawg-tools

    # Telegram client
    unstable.ayugram-desktop

    # BitTorrent client
    transmission_4-qt

    # Video player
    vlc

    # Postgres
    postgresql

    staruml

    # Wine
    wineWowPackages.waylandFull

    # Steam run
    steam-run

    # Games
    chocolate-doom
    inputs.self.packages.x86_64-linux.prismlauncher-appimage

    appimage-run

    # Libs
    alsa-lib
    udev
    pkg-config
    xorg.libX11
    glib


    # F*
    # fstar
    # z3

    # Bottles
    # bottles


    # Camera app
    # cheese

    # Koka
    # koka

    # Erlang and Elixir
    # erlang_28
    # unstable.beam28Packages.elixir

    # triton-llvm

    # Futhark 
    # unstable.futhark
    # haskellPackages.futhark-server

    # Agda
    # (agda.withPackages [ agdaPackages.standard-library agdaPackages.cubical ])
  ];
}
