{ config, pkgs, inputs, ... }:

{
  imports = [
    #<catppuccin/modules/home-manager>
    ./scripts/scripts.nix
    ./nixy.nix
    ./helix.nix
    inputs.hyprland.homeManagerModules.default
  ];
  nixpkgs.config.allowUnfree = true; 
  home.username = "home";
  home.homeDirectory = "/home/home";
  programs.cava = {
      enable = true;
  };
  programs.bottom = {
    enable = true;
  };
  programs.btop = {
    enable = true;
  };
   programs.bat = {
    enable = true;
  };
  programs.zathura = {
    enable = true;
  };
  #yazi.enable = true;
  programs.imv = {
    enable = true;
  };
  programs.git = {
    enable = true;
    userName = "vasaofficial";
    userEmail = "vasapofficial@gmail.com";
  };
  catppuccin.enable = true;
  #programs.hyprland.withUWSM  = true;
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };
  wayland.windowManager.hyprland.systemd.enable = false;
  wayland.windowManager.hyprland.extraConfig = ''
      $configs = $HOME/.config/hypr/configs
      source=$configs/Settings.conf
      source=$configs/Keybinds.conf
      $UserConfigs = $HOME/.config/hypr/UserConfigs
      source= $UserConfigs/Startup_Apps.conf
      source= $UserConfigs/ENVariables.conf
      source= $UserConfigs/Monitors.conf
      source= $UserConfigs/Laptops.conf
      source= $UserConfigs/LaptopDisplay.conf
      source= $UserConfigs/WindowRules.conf
      source= $UserConfigs/UserDecorAnimations.conf
      source= $UserConfigs/UserKeybinds.conf
      source= $UserConfigs/UserSettings.conf
      source= $UserConfigs/WorkspaceRules.conf
      source= $HOME/.config/hypr/themes/mocha.conf
  '';

  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.borders-plus-plus
    ];
  };
  home.stateVersion = "25.05";
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      packages = pkgs.papirus-icon-theme;
    };
    theme.packages = pkgs.catppuccin-gtk.override {
      accents = [ "mauve" ]; # You can specify multiple accents here to output multiple themes 
      size = "standard";
      variant = "mocha";
    };
    theme.name = "catppuccin-Dark";
     gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };
  };
 
  home.packages = [
    (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
    pkgs.buildFHSUserEnv (base // {
    name = "fhs";
    targetPkgs = pkgs: 
      # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
      # lacking many basic packages needed by most software.
      # Therefore, we need to add them manually.
      #
      # pkgs.appimageTools provides basic packages required by most software.
      (base.targetPkgs pkgs) ++ (with pkgs; [
        pkg-config
        ncurses
        # Feel free to add more packages here if needed.
      ]
    );
    profile = "export FHS=1";
    runScript = "bash";
    extraOutputsToInstall = ["dev"];
  }))
    
    # (pkgs.nerd-fonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.hyprpanel
    pkgs.nitch
    pkgs.hiddify-app
    pkgs.neofetch
    pkgs.github-cli
    inputs.ags.packages."${pkgs.system}".default
    inputs.astal.packages."${pkgs.system}".default
    #inputs.yazi.packages.${pkgs.system}.default
    pkgs.vscodium
    pkgs.libdbusmenu-gtk3
    pkgs.dbus-glib
    pkgs.gtkmm3
    pkgs.gtkmm4
    pkgs.gtkmm2
    pkgs.gowall 
  ];

  
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/antonio/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR="nvim";
     TERMINAL="kitty";
     VISUAL="codium";
     BROWSER="firefox";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}