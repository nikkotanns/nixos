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

    neofetch

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
    unstable.code-cursor
    unstable.antigravity

    clang

    # Rust
    unstable.rustc
    unstable.cargo
    unstable.rustfmt
    unstable.rust-analyzer

    # Agda
    (agda.withPackages [ agdaPackages.standard-library agdaPackages.cubical ])

    # Lean 4
    unstable.elan

    # GAP – A System for Computational Discrete Algebra
    gap

    # F*
    fstar
    z3

    # Typst
    unstable.typst
    unstable.typstyle
    unstable.typstyle
    unstable.typst-live
    unstable.typstwriter
    unstable.tinymist

    # Obsidian
    unstable.obsidian

    # Koka
    koka

    # Erlang and Elixir
    erlang_28
    unstable.beam28Packages.elixir

    triton-llvm

    # Futhark 
    unstable.futhark
    haskellPackages.futhark-server

    # OpenCL
    clinfo
    khronos-ocl-icd-loader

    # Nix language
    nil
    nixpkgs-fmt
    inputs.nix-alien.packages.${stdenv.hostPlatform.system}.nix-alien # Nix alien

    # Python
    python313

    # Javascript
    unstable.bun

    # Golang
    go

    # Kubernetes
    kubectl
    unstable.kind

    # Proxy
    unstable.xray
    amnezia-vpn
    amneziawg-go
    amneziawg-tools

    # Telegram client
    unstable.ayugram-desktop

    # BitTorrent client
    transmission_4-qt

    # Camera app
    cheese

    # Video player
    vlc

    # Notebook
    rnote

    # Postgres
    postgresql

    # Wine
    wineWowPackages.waylandFull

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
  ];
}
