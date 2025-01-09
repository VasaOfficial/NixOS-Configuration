{ ... }: 
{
  security.rtkit.enable = true;
  security.sudo.enable = true;
  # POTENTALY UNCOMMENT THIS IF USING HYPRLAND
  # security.pam.services.swaylock = { };
  # security.pam.services.hyprlock = {};
}