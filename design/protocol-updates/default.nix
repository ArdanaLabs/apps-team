{ chan ? "7e9b0dff974c89e070da1ad85713ff3c20b0ca97"
, pkgs ? import (builtins.fetchTarball { url = "https://github.com/NixOS/nixpkgs/archive/${chan}.tar.gz"; }) {}
}:
with pkgs;
let deps = [ (texlive.combine { inherit (texlive) scheme-basic amsmath outlines graphics hyperref; }) ];
in
  stdenv.mkDerivation {
    name = "whitepaper";
    src = ./.;
    buildInputs = deps;
    buildPhase = ''
      mkdir -p $out
      HOME=./. pdflatex doc.tex
      HOME=./. pdflatex doc.tex
      cp doc.pdf "$out/protocol-updates.pdf"
    '';
    installPhase = ''
      echo done
    '';
  }
