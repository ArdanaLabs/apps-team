{ chan ? "7e9b0dff974c89e070da1ad85713ff3c20b0ca97"
, pkgs ? import (builtins.fetchTarball { url = "https://github.com/NixOS/nixpkgs/archive/${chan}.tar.gz"; }) {}
}:
with pkgs;
let deps = [ (texlive.combine { inherit (texlive) scheme-basic amsmath graphics; }) ];
in
  stdenv.mkDerivation {
    name = "spec";
    src = ./.;
    buildInputs = deps;
    buildPhase = ''
      mkdir -p $out
      HOME=./. pdflatex spec.tex
      cp spec.pdf "$out/DanaSwap Spec.pdf"
    '';
    installPhase = ''
      echo done
    '';
  }
