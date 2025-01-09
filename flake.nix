{
  description = "Temujins configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    stylix.url = "github:danth/stylix/release-24.11";
  
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
  
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };

    spicetify-nix.url = "github:gerg-l/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    
    #### TO LEARN WHAT ARE THESE

    # hyprland = {
    #   type = "git";
    #   url = "https://github.com/hyprwm/Hyprland";
    #   submodules = true;
    # };

    # hypr-contrib.url = "github:hyprwm/contrib";
    # hyprpicker.url = "github:hyprwm/hyprpicker";
  };

  outputs = { nixpkgs, self, ghostty, ...} @ inputs:
  let
    username = "temujin";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in
  {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ 
          (import ./hosts/desktop)
          inputs.stylix.nixosModules.stylix
          {
          environment.systemPackages = [
            ghostty.packages.x86_64-linux.default
          ];
        }
        ];
        specialArgs = { host="desktop"; inherit self inputs username ; };
      };
    };
  };
}