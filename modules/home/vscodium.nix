{ pkgs, ... }: 
let
  lib = pkgs.lib;  # Import lib from pkgs
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      ms-python.python
      ms-python.vscode-pylance
      ms-kubernetes-tools.vscode-kubernetes-tools
      visualstudioexptteam.vscodeintellicode
      hashicorp.terraform
      golang.go
      github.vscode-pull-request-github
      donjayamanne.githistory
      mhutchie.git-graph
      mikestead.dotenv
      ms-azuretools.vscode-docker
      streetsidesoftware.code-spell-checker
      redhat.ansible
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      redhat.vscode-yaml
      tomoki1207.pdf

      # bmalehorn.vscode-python-indent
    ];
    userSettings = {
      "update.mode" = "start";
      "extensions.autoUpdate" = true; # This stuff fixes vscode freaking out when theres an update
      "window.titleBarStyle" = "custom"; # needed otherwise vscode crashes, see https://github.com/NixOS/nixpkgs/issues/246509

      "window.menuBarVisibility" = "toggle";
      "editor.fontFamily" = "JetBrainsMono Nerd Font Mono";
      "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Mono";
      "editor.fontSize" = lib.mkForce 16;
      "workbench.colorTheme" = lib.mkForce "Catppuccin Mocha";
      "workbench.iconTheme" = lib.mkForce "catppuccin-mocha";
      "catppuccin.accentColor" = lib.mkForce "lavender";
      "vsicons.dontShowNewVersionMessage" = true;
      "explorer.confirmDragAndDrop" = false;
      "editor.fontLigatures" = true;
      "editor.minimap.enabled" = false;
      "workbench.startupEditor" = "none";

      "files.autoSave" = "onFocusChange";
      "editor.tabSize" = 2;
      "editor.wordWrap" = "on";

      "editor.smoothScrolling" = true;
      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = "on";
      "workbench.list.smoothScrolling" = true;
      "terminal.integrated.smoothScrolling" = true;
      "terminal.integrated.cursorBlinking" = true;
    };
    # Keybindings
    keybindings = [
      {
        key = "ctrl+q";
        command = "editor.action.commentLine";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+s";
        command = "workbench.action.files.saveFiles";
      }
    ];
  };
}