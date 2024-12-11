{ pkgs, config, host, username, options, lib, inputs, system, ... }:
{
  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
    clean = {
      enable = true;
      extraArgs = "--keep-since-1w";
    };
  };
}