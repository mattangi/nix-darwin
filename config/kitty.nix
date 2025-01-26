{ config, pkgs, lib, ... }:

{
    enable = true;
    shellIntegration.mode = "no-sudo";
    extraConfig = ''
    font_family      MesloLGS Nerd Font Mono Regular
    bold_font        MesloLGS Nerd Font Mono Bold
    italic_font      MesloLGS Nerd Font Mono Italic
    bold_italic_font MesloLGS Nerd Font Mono Bold Italic
    font_size 16.0

    #cursor settings
    cursor #38ff9c
    cursor_text_color #000000
    cursor_shape block

    scrollback_lines 2000

    copy_on_select no

    enable_audio_bell yes

    remember_window_size  yes
    initial_window_width  640
    initial_window_height 400

    foreground #ebddf4
    background #010b17
    background_opacity 0.95
    selection_foreground #000000
    selection_background #38ff9c

    color0 #0b3b61
    color8 #62686c
    #: black
    color1 #ff3a3a
    color9 #ff54b0
    #: red
    color2  #52ffcf
    color10 #73ffd8
    #: green
    color3  #fff383
    color11 #fcf4ad
    #: yellow
    color4  #1376f8
    color12 #378dfe
    #: blue
    color5  #c792ea
    color13 #ae81ff
    #: magenta
    color6  #ff5dd4
    color14 #ff69d7
    #: cyan
    color7  #15fca2
    color15 #5ffbbe
    #: white
    '';
}