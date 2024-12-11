# Main default config
{ config, pkgs, host, username, options, lib, inputs, system, ...}: let
  
  inherit (import ./variables.nix) keyboardLayout;
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
      ]
  );
  
  in {
  imports = [
    ./hardware.nix
    ./users.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    ../../modules/amd-drivers.nix
    ../../modules/bootloader.nix
    ../../modules/system.nix
    ../../modules/wayland.nix
    ../../modules/services.nix
    ../../modules/hardwareconf.nix
    ../../modules/virtualization.nix
    ../../modules/network.nix
    ../../modules/fonts.nix
    ../../modules/nh.nix
    ../../modules/audio.nix
    ../../modules/powermanagement.nix
    # ../../modules/scheduler.nix
    ../../modules/displaymanager.nix
    ../../modules/locale.nix
    ../../modules/stylix.nix
    ../../modules/locale.nix
  ];
       
  nixpkgs.overlays = [
    (final: prev: {
      matugen = final.rustPlatform.buildRustPackage rec {
        pname = "matugen";
        version = "2.4.0";

        src = final.fetchFromGitHub {
          owner = "InioX";
          repo = "matugen";
          rev = "refs/tags/v${version}";
          hash = "sha256-l623fIVhVCU/ylbBmohAtQNbK0YrWlEny0sC/vBJ+dU=";
        };

        cargoHash = "sha256-FwQhhwlldDskDzmIOxhwRuUv8NxXCxd3ZmOwqcuWz64=";

        meta = {
          description = "Material you color generation tool";
          homepage = "https://github.com/InioX/matugen";
          changelog = "https://github.com/InioX/matugen/blob/${src.rev}/CHANGELOG.md";
          license = final.lib.licenses.gpl2Only;
          maintainers = with final.lib.maintainers; [ lampros ];
          mainProgram = "matugen";
        };
      };
    })
    (final: prev: {
        sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
        pname = "sf-mono-liga-bin";
        version = "dev";
        src = inputs.sf-mono-liga-src;
        dontConfigure = true;
        installPhase = ''
          mkdir -p $out/share/fonts/opentype
          cp -R $src/*.otf $out/share/fonts/opentype/
          '';
      };
    }) 
  ];  

  drivers.amdgpu.enable = true;
  vm.guest-services.enable = true;
  local.hardware-clock.enable = true;
  nixpkgs.config.allowUnfree = true;
  
  users = {
    mutableUsers = true;
  };

  environment.systemPackages = (with pkgs; [
    mesa
    egl-wayland
    #waybar  # if wanted experimental next line
    #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
  ]) ++ [
	  python-packages
  ];
  
  hardware.graphics = {
    enable = true;
  };
  console.keyMap = "${keyboardLayout}";
  
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables = {
  EDITOR = "nvim"; #change to vscode
  BROWSER = "firefox";  #change to brave
  TERMINAL = "kitty";
  GSK_RENDERER = "gl";
};

  system.stateVersion = "25.05";
}
