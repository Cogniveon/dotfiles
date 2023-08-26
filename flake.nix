{
  description = "AlQaholic's NixOS dotfiles";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    pkgs = import nixpkgs { inherit system; };
    system = "x86_64-linux";
  in
  {
    # NixOS configuration entrypoint
    # Available through "sudo nixos-rebuild switch --flake '.#hostname'"
    nixosConfigurations = import ./hosts inputs;

    
    # Home Manager configuration entrypoint
    # Available through "home-manager switch --flake '.#username'"
    homeConfigurations.alqaholic = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      # Pass flake inputs to our config
      extraSpecialArgs = { inherit inputs; };
      # > home-manager configuration file
      modules = [ ./modules/home ];
    };
    
    formatter.${system} = pkgs.alejandra;
  };
}
