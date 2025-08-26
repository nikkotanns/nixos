# pkgs/prismlauncher-appimage.nix
{ lib, fetchurl, appimageTools }:
appimageTools.wrapType2 rec {
  pname = "prismlauncher-cracked";
  version = "9.4";

  src = fetchurl {
    url = "https://github.com/Diegiwg/PrismLauncher-Cracked/releases/download/${version}/PrismLauncher-Linux-x86_64.AppImage";
    sha256 = lib.fakeHash; # собери один раз, замени на реальный хеш
  };

  meta = with lib; {
    description = "Prism Launcher AppImage wrapper";
    homepage = "https://prismlauncher.org";
    license = licenses.unfreeRedistributable;
    mainProgram = pname;
    platforms = platforms.linux;
  };
}
