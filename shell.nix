{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.gnumake
    pkgs.python39Packages.markdown
    pkgs.python39Packages.pelican
  ];
}
