{ pkgs, unstable, inputs, ... }: {
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
