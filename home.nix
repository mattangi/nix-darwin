{ config, pkgs, inputs, lib, ... }:
let 
  globals = import ./globals.nix;
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "${globals.myinfo.user}";
  home.homeDirectory = "/Users/${globals.myinfo.user}";
  home.enableNixpkgsReleaseCheck = false;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  #home.stateVersion = "24.11";
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      #pinentryPackage = pkgs.pinentry_mac;
      pinentry.package = pkgs.pinentry_mac;
    };
  };

#  programs = {} // import ./config/kitty.nix {inherit config pkgs lib; };

  programs ={
    zsh = {} // import ./config/zsh.nix {inherit config pkgs lib; };
#    kitty = {} // import ./config/kitty.nix {inherit config pkgs lib; };
    yazi = {} // import ./config/yazi/yazi.nix {inherit config pkgs lib; };
#    neovim = {} // import ./config/neovim/neovim.nix {inherit config pkgs lib; };

    git = {
      enable = true;
      ignores = [ "*.swp" ".DS_Store" ];
      userName = globals.myinfo.gituser;
      userEmail = globals.myinfo.email;
      lfs = {
        enable = true;
      };
      signing.key = "6ECDE3E8177091AF";
      extraConfig = {
        init.defaultBranch = "main";
        core = {
        editor = "vim";
          autocrlf = "input";
        };
        commit.gpgsign = true;
        pull.rebase = true;
        rebase.autoStash = true;
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    ripgrep.enable = true;
    gpg.enable = true;
    fzf.enable = true;
    bat.enable = true;
    eza.enable = true;
    lazygit.enable = true;
  };

  home.file = {
    "/Users/${globals.myinfo.user}/.config/nvim".source = ./config/nvim;
    "/Users/${globals.myinfo.user}/.config/aerospace".source = ./config/aerospace;
    "/Users/${globals.myinfo.user}/.config/ghostty".source = ./config/ghostty;
  };

}
