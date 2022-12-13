{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.gnumake
    pkgs.python310Packages.markdown
    pkgs.python310Packages.pelican
  ];
}
