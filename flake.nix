{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
   
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs = {
        url = "github:nix-community/nix-doom-emacs";
        inputs.nixpkgs.follows = "nixpkgs";
    };

     nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { nixpkgs, home-manager, nix-doom-emacs, nixvim, ... }@inputs:
    {
      nixosConfigurations = {
        anya = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              ./system
              ./system/anya
            ];
        };
      };
      homeConfigurations."andalusia@anya" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
            inherit inputs; 
            flake-inputs = inputs;
            };
        modules = [ 
            ./home 
            ./home/wm
            ./home/alacritty
            nixvim.homeManagerModules.nixvim
            ./home/nixvim
        ];
      };
    };
}
