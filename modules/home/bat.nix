{ inputs, pkgs, ... }: 
let
  lib = pkgs.lib;  # Import lib from pkgs
in
{
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = lib.mkForce "Dracula";
    };
  };
}