{ pkgs, unstable, inputs, ... }: {
  home.packages = with pkgs; [
    glib

    # Desktop
    libnotify
    waybar
    wpaperd
    rofi
    blueman
    networkmanagerapplet
    capitaine-cursors
    # pipewire
    # wireplumber
    hyprpolkitagent
    brightnessctl
    hyprshot
    wl-clipboard


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
    (agda.withPackages [ agdaPackages.standard-library ])

    # Lean 4
    unstable.elan

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


    # BitTorrent client
    transmission_4-qt

    # Camera app
    cheese


    # Video player
    vlc

    # Doom
    chocolate-doom


    # Libs
    alsa-lib
    udev
    pkg-config
    xorg.libX11
  ];
}
