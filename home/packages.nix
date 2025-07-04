{ pkgs, unstable, inputs, ... }: {
  home.packages = with pkgs; [

    # Desktop
    libnotify
    waybar
    wpaperd
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

    gh

    unstable.vscode
    # unstable.code-cursor

    clang

    # Rust
    unstable.rustc
    unstable.cargo
    unstable.rustfmt
    unstable.rust-analyzer

    # Haskell
    ghc
    cabal-install
    haskellPackages.cabal-fmt
    haskell-language-server
    ormolu
    zlib

    # Agda
    (agda.withPackages [ agdaPackages.standard-library agdaPackages.cubical ])

    # Lean 4
    unstable.elan

    # Typst
    unstable.typst
    unstable.typstyle
    unstable.typstfmt
    unstable.typst-live
    unstable.typstwriter
    unstable.tinymist

    # Obsidian
    unstable.obsidian

    # Koka
    koka

    triton-llvm

    # Futhark 
    unstable.futhark
    haskellPackages.futhark-server

    # OpenCL
    clinfo
    khronos-ocl-icd-loader
    oclgrind

    # Nix language
    nil
    nixpkgs-fmt
    inputs.nix-alien.packages.${system}.nix-alien # Nix alien

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
    unstable.amnezia-vpn
    unstable.amneziawg-go
    unstable.amneziawg-tools

    # Telegram client
    unstable.ayugram-desktop

    # BitTorrent client
    transmission_4-qt

    # Camera app
    cheese

    # Video player
    vlc

    # PDF Editor
    libsForQt5.okular

    # Notebook
    rnote

    # Postgres
    postgresql

    # Wine
    wineWowPackages.waylandFull

    # Doom
    chocolate-doom


    # Libs
    alsa-lib
    udev
    pkg-config
    xorg.libX11
    glib
  ];
}
