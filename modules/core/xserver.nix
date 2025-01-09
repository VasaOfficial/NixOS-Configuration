{ pkgs, username, ... }: 
{
  services = {
    # REMOVE THIS POTENTIALLY
    xserver = {
      enable = true;
      xkb.layout = "us";
    };

    displayManager.autoLogin = {
      enable = true;
      user = "${username}";
    };
     
    # REMOVE THIS IF YOU DONT WANT TO HAVE KDA PLASMA
    displayManager.sddm = {
      enable = true;
    };
    desktopManager.plasma6.enable = true;

    libinput = {
      enable = true;
      # mouse = {
      #   accelProfile = "flat";
      # };
    };
  };
  # To prevent getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}