{ inputs, pkgs, ... }: 
let 
in
{
  home.packages = (with pkgs; [    
    brave
    ansible
    qalculate-gtk                     # calculator
    yazi                              # terminal file manager
    python3
    evince                            # gnome pdf viewer
    fzf                               # fuzzy finder
    thefuck
    fastfetch
    starship
    nautilus                          # file manager
    nitch                             # systhem fetch util
    eza                               # ls replacement
    fd  
    htop                              # find replacement
    ripgrep                           # grep replacement
    inputs.alejandra.defaultPackage.${system}

    docker                            # Docker CLI
    docker-compose                    # Docker Compose
    terraform                         # Infrastructure as code tool
    k9s                               # Kubernetes terminal UI
    # helm and helmfile
    lazydocker
    nodejs                            # Node.js runtime
    awscli                            # AWS CLI
    minikube
    lens                              # Kubernetes IDE
    devbox                            # Nix like program for development
    # mpv                             # Video player 
    # notion

    # for wayland possibly 
    # wl-clipboard                      # clipboard utils for wayland (wl-copy, wl-paste)
    # cliphist                          # clipboard manager
    # poweralertd
    # ticktick 
    # qbittorrent                       # Torrent client
    # vlc                               # Video player
    # obsidian                          # Markdown knowledge base
    # golang                            # Go programming language
    # vagrant
    # tableplus                         # Database GUI (via third-party overlays)
    # postman                           # API testing tool
    # notion-app                        # Notion client
  ]);
}