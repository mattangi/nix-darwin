{ config, pkgs, myinfo, ... }:

{
    dock = {
        enable = true;
        entries = [
          { path = "/Applications/Safari.app"; }
          { path = "/Applications/ghostty.app"; }
#          { path = "${pkgs.kitty}/Applications/kitty.app"; }
          { path = "${pkgs.vscode}/Applications/Visual Studio Code.app"; }
          { path = "/System/Applications/System Settings.app/"; }
          {
            path = "/Applications";
            section = "others";
            options = "--sort name --view grid --display folder";
          }
          {
            path = "/Users/${myinfo.user}/Downloads/";
            section = "others";
            options = "--sort name --view grid --display folder";
          }
          {
            path = "/Users/${myinfo.user}/Documents";
            section = "others";
            options = "--sort name --view grid --display stack";
          }
        ];
      };
}