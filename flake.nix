{
  description = "A flake that exports the mbslave python package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    poetry2nix.url = "github:nix-community/poetry2nix";
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; }) mkPoetryApplication;

        let mbslave = mkPoetryApplication {
          python = pkgs.python311;
          projectDir = pkgs.fetchFromGitHub {
            owner = "acoustid";
            repo = "mbslave";
            rev = "v29.0.0";
            sha256 = "";
          };
        };
      in 
      {
        package.mbslave = mbslave;
      });
}
