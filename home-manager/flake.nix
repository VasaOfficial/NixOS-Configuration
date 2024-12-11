{
  description = "Home Manager configuration of antonio";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    catppuccin.url = "github:catppuccin/nix";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    ags = {
        url = "github:aylur/ags";
        inputs.nixpkgs.follows = "nixpkgs";
     };
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nyxexprs.url = "github:notashelf/nyxexprs";
    yazi.url = "github:sxyazi/yazi";
   };
  outputs = inputs @ { nixpkgs, yazi, home-manager, hyprpanel, catppuccin, hyprland, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          inputs.hyprpanel.overlay
          (final: prev: {
           })
        ];
      };

    in {
      homeConfigurations."nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
        ./home.nix
        #yazi.homeManagerModules.yazi
        catppuccin.homeManagerModules.catppuccin
        #{
          #wayland.windowManager.hyprland = {
          #  enable = true;
          #  package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          #};
        #}
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}