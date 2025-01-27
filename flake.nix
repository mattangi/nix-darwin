{
  description = "My nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
#    nixvim.url = "github:nix-community/nixvim";
#    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
  let
  myinfo = {
    user = "mattangi";
    name = "Kevin Yoon";
    email = "mattangi@gmail.com";
  };
  arch = "aarch64-darwin"; # x86_64-darwin
  configuration = { pkgs, config, ... }: {
    imports = [
      ./dock
    ];

    local = {} // import ./dock/dock.nix {inherit config pkgs myinfo; };

    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = pkgs.callPackage ./packages/nixpkgs.nix {};
        
    homebrew = {
      enable = true;
      brews = pkgs.callPackage ./packages/brewpkgs.nix {};
      casks = pkgs.callPackage ./packages/caskpkgs.nix {};
      masApps = {} // import ./packages/maspkgs.nix {};
      
      onActivation.cleanup = "zap";
      onActivation.autoUpdate = true;
      onActivation.upgrade = true;
    };

    fonts.packages = [
	    #pkgs.meslo-lgs-nf
    ];

    system.activationScripts.applications.text = let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
	    };
      in
      pkgs.lib.mkForce ''
      # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
      '';

    users.users.${myinfo.user}.home = "/Users/${myinfo.user}";
    home-manager.backupFileExtension = "backup";
    nix.configureBuildUsers = true;
    nix.useDaemon = true;

    system.defaults = {
      dock = {
        autohide = true;
        mineffect = "genie";
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        magnification = true;
        tilesize = 64;
        largesize = 128;
      };

      finder = {
        ShowStatusBar = true;
        ShowHardDrivesOnDesktop = true;
        AppleShowAllExtensions = true;
      };

      loginwindow = {
        GuestEnabled = false;
        SHOWFULLNAME = true;
      };

      magicmouse.MouseButtonMode = "TwoButton";
    };

    services.nix-daemon.enable = true;
    #services.karabiner-elements.enable = true;
    #services.karabiner-elements.package = pkgs.karabiner-elements;

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # Enable alternative shell support in nix-darwin.
    programs.zsh.enable = true;
    
#    yazi = {} // import ./config/yazi/yazi.nix { inherit config pkgs lib; };

#    programs.nixvim = {} // import ./config/neovim/nixvim.nix { inherit config pkgs nixvim; };
  
    # Set Git commit hash for darwin-version.
    system.configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 5;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "${arch}";
  };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#mbp
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      system = "${arch}";
      modules = [ 
        configuration
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${myinfo.user} = import ./home.nix;
        }
#        nixvim.nixDarwinModules.nixvim
	      nix-homebrew.darwinModules.nix-homebrew
        {
	        nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "${myinfo.user}";

            # if already installed homebrew
            # autoMigrate = true;
	        };
	      }
      ];
    };
    
    darwinPackages = self.darwinConfigurations."mbp".pkgs;
  };
}
