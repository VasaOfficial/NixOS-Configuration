{inputs, username, host, ...}: {
  imports =
       [(import ./bat.nix)]                       # better cat command
    ++ [(import ./fuzzel.nix)]                    # launcher
    ++ [(import ./git.nix)]                       # version control
    ++ [(import ./kitty.nix)]                     # terminal
    ++ [(import ./swaync/swaync.nix)]             # notification deamon
    ++ [(import ./nvim.nix)]                      # neovim editor
    ++ [(import ./packages.nix)]                  # other packages
    ++ [(import ./spicetify.nix)]                 # spotify client
    # ++ [(import ./starship.nix)]                  # shell prompt
    ++ [(import ./vscodium.nix)]                  # vscode forck
    ++ [(import ./zsh.nix)];                      # shell
    # ++ [(import ./hyprland)]                      # window manager
    # ++ [(import ./swaylock.nix)]                  # lock screen
    # ++ [(import ./waybar)]                        # status bar
}