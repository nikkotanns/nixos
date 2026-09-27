{ pkgs, unstable, inputs, ... }:
let
  prismlauncher-cracked = pkgs.appimageTools.wrapType2 rec {
    pname = "prismlauncher-cracked";
    version = "11.0.3";
    src = pkgs.fetchurl {
      url = "https://github.com/Diegiwg/PrismLauncher-Cracked/releases/download/${version}/PrismLauncher-Linux-x86_64.AppImage";
      sha256 = "sha256-dVlHFnLLs2+24hWdiUqW2aVtpWN3DcdLmC2Ekn7la+A=";
    };
  };
in
{
  home.packages = with pkgs; [

    # Desktop
    libnotify
    rofi
    blueman
    networkmanagerapplet
    phinger-cursors
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
    rclone

    gh

    unstable.vscode

    python314


    R

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

    # Minecraft
    prismlauncher-cracked

    appimage-run

    # Genealogy
    (pkgs.symlinkJoin {
      name = "gramps-ru";
      paths = [ pkgs.gramps ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/gramps \
          --set LANG ru_RU.UTF-8 \
          --set LC_ALL ru_RU.UTF-8
      '';
    })

    # Libs
    alsa-lib
    udev
    pkg-config
    libX11
    glib
  ];
}
