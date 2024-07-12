{
  description = "A flake that exports the mbslave python package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    poetry2nix.url = "github:nix-community/poetry2nix";
  };

  outputs = { self, nixpkgs, poetry2nix }:
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; }) mkPoetryApplication;

      mbslave = mkPoetryApplication {
        python = pkgs.python311;
        preferWheels = true;
        projectDir = pkgs.fetchFromGitHub {
          owner = "acoustid";
          repo = "mbslave";
          rev = "v29.0.0";
          sha256 = "sha256-MdtGLAUA5J0i4pNzbU4pTOeZN78lBRKtb6pHRdY7j6k=";
        };
      };
    in 
    {
   
      packages.${system} = {
        default = self.packages.${system}.mbslave;
        mbslave = mbslave;
      };
    };
}
