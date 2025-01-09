{ pkgs, ... }: 
{
  programs.git = {
    enable = true;
    
    userName = "VasaOfficial";
    userEmail = "vasapofficial@gmail.com";
    
    extraConfig = { 
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  # home.packages = [ pkgs.gh pkgs.git-lfs ];
}