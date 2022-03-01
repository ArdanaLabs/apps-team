{ chan ? "7e9b0dff974c89e070da1ad85713ff3c20b0ca97"
, pkgs ? import (builtins.fetchTarball { url = "https://github.com/NixOS/nixpkgs/archive/${chan}.tar.gz"; }) {}
}:
with pkgs;
let deps = [ (texlive.combine { inherit (texlive) scheme-basic amsmath xcolor; }) ];
in
  stdenv.mkDerivation {
    name = "ardana-dollar";
    src = ./.;
    buildInputs = deps;
    buildPhase = ''
      mkdir -p $out
      HOME=./. pdflatex ardana-dollar.tex
      cp ardana-dollar.pdf "$out/Ardana-Dollar-Overview.pdf"
    '';
    installPhase = ''
      echo done
    '';
  }
