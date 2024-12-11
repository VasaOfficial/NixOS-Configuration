{ pkgs, username, ... }:

let
  inherit (import ./variables.nix) gitUsername;
in
{
  users = { 
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video" 
        "input" 
        "audio"
      ];

    # define user packages here
    packages = with pkgs; [
      ];
    };
    
    defaultUserShell = pkgs.zsh;
  }; 
  
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ fzf ]; 

  programs = {
   #Zsh configuration
	  zsh = {
    	enable = true;
	  	enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "duellj"; 
        plugins = [
          "git"
          "thefuck"
        ];
      };
      
      promptInit = ''
        fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
        
        source <(fzf --zsh);
        HISTFILE=~/.zsh_history;
        HISTSIZE=10000;
        SAVEHIST=10000;
        setopt appendhistory;
      '';
    };
  };
}
