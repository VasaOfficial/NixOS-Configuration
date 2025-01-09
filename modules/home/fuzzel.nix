{ lib, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = lib.mkForce "JetBrainsMono Nerd Font:weight=bold:size=14";
        line-height = 25;
        fields = "name,generic,comment,categories,filename,keywords";
        terminal = "kitty";
        prompt = "' ➜  '" ;
        icon-theme = "Papirus-Dark";
        layer = "top";
        lines = 10;
        width = 35;
        horizontal-pad = 25;
        inner-pad = 5;
      };
      colors = {
        background = lib.mkForce "1e1e2ecc";
        text = "cdd6f4ff";
        match = lib.mkForce "f38ba8ff";
        selection = lib.mkForce "b4befeaa";
        selection-match = lib.mkForce "f38ba8ff";
        selection-text = "cdd6f4ff";
        border = lib.mkForce "b4befeff";
      };
      border = {
        radius = 15;
        width = 3;
      };
    };
  };
}