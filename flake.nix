{
  description = "Temujin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    matugen = {
      url = "github:/InioX/Matugen";
    };

    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # hyprland development
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
    stylix.url = "github:danth/stylix";
    nixos-boot.url = "github:Melkor333/nixos-boot";
    nyxexprs.url = "github:notashelf/nyxexprs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dedsec-grub-theme = {
      url = "gitlab:VandalByte/dedsec-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sddm-sugar-candy-nix = {
      url = "github:maotseantonio/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , home-manager
    , ...
    }:
    let
      system = "x86_64-linux";
      host = "nixos";
      username = "nixos";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
            inherit username;
            inherit host;
          };
          modules = [
            ./hosts/${host}/config.nix
            inputs.dedsec-grub-theme.nixosModule
            inputs.nixos-boot.nixosModules.default
            inputs.sddm-sugar-candy-nix.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            { nixpkgs.overlays = [ inputs.hyprpanel.overlay ]; }
          ];
        };
      };
    };
}