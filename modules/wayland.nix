{ inputs, pkgs, ... }:
{
  programs = {
	  hyprland = {
          enable = true;
		  package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
		  portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; # xdphls
  	  xwayland.enable = true;
      };

      nix-ld.enable = true;
	    waybar.enable = false; # possibly enable this one
	    hyprlock.enable = true;
	    firefox.enable = true;
	    git.enable = true;
      nm-applet.indicator = true;
      #neovim.enable = true;

	    thunar.enable = true;
	    thunar.plugins = with pkgs.xfce; [
		    exo
		    mousepad
		    thunar-archive-plugin
		    thunar-volman
		    tumbler
  	  ];
	
    virt-manager.enable = false;
    xwayland.enable = true;

    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl # for brightness control
    cliphist
    eog
    gnome-system-monitor
    file-roller
    grim
    gtk-engine-murrine #for gtk themes
    hyprcursor # requires unstable channel
    hypridle # requires unstable channel
    imagemagick 
    inxi
    jq
    kitty
    libsForQt5.qtstyleplugin-kvantum
    networkmanagerapplet
    nwg-look # requires unstable channel
    nwg-dock-hyprland
    nvtopPackages.full
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    pyprland
    libsForQt5.qt5ct
    qt6ct
    qt6.qtwayland
    qt6Packages.qtstyleplugin-kvantum
    rofi-wayland
    slurp
    swappy
    swww
    unzip
    wallust
    wl-clipboard
    wlogout
    yad
    nix-ld
    power-profiles-daemon
    fd
    home-manager
    bluez-tools
    wgpu-utils   
    yazi
    gtk3
    gtk4
    atuin
    bun
    dart-sass 
    nodejs
    sassc
    libgtop
    starship
    vesktop
    papirus-folders
    papirus-icon-theme
    sddm 
    catppuccin-sddm-corners
    zoxide
    bibata-cursors
  ];
}