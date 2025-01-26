{ config, pkgs, nixvim, ... }:

{
    globals = {
        mapleader = " ";
        loaded_netrw = 1;
        loaded_netrwPlugin = 1;
    };

    enable = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.tokyonight.enable = true;

    extraConfigLua = ''
        vim.cmd("let g:netrw_liststyle = 3")
    '';

    opts = {
        relativenumber = true;
        number = true;

        # tabs & indentation
        tabstop = 2; # 2 spaces for tabs (prettier default)
        shiftwidth = 2; # 2 spaces for indent width
        expandtab = true; # expand tab to spaces
        autoindent = true; # copy indent from current line when starting new one

        wrap = false;

        # earch settings
        ignorecase = true; # -- ignore case when searching
        smartcase = true;  #-- if you include mixed case in your search, assumes you want case-sensitive

        cursorline = true;

        # -- turn on termguicolors for tokyonight colorscheme to work
        # -- (have to use iterm2 or any other true color terminal)
        termguicolors = true;
        background = "dark"; # -- colorschemes that can be light or dark will be made dark
        signcolumn = "yes"; # -- show sign column so that text doesn't shift

        # -- backspace
        backspace = "indent,eol,start"; # -- allow backspace on indent, end of line or insert mode start position

        #-- clipboard
        # clipboard:append("unnamedplus"); # -- use system clipboard as default register

        # -- split windows
        splitright = true; # -- split vertical window to the right
        splitbelow = true; # -- split horizontal window to the bottom

        # -- turn off swapfile
        swapfile = false;
    };

    keymaps = [
        # nvim-tree keymaps
        { action = "<cmd>NvimTreeToggle<CR>"; key = "<leader>ee"; mode = "n"; }
        { action = "<cmd>NvimTreeFindFileToggle<CR>"; key = "<leader>ef"; mode = "n"; }
        { action = "<cmd>NvimTreeCollapse<CR>"; key = "<leader>ec"; mode = "n"; }
        { action = "<cmd>NvimTreeRefresh<CR>"; key = "<leader>er"; mode = "n"; }

        # nvim-telescope keymaps
        { action = "<cmd>Telescope find_files<CR>"; key = "<leader>ff"; mode = "n"; }
        { action = "<cmd>Telescope oldfilesCR>"; key = "<leader>fr"; mode = "n"; }
        { action = "<cmd>Telescope live_grep<CR>"; key = "<leader>fg"; mode = "n"; }
        { action = "<cmd>Telescope grep_string<CR>"; key = "<leader>fc"; mode = "n"; }
        { action = "<cmd>Telescope help_tags<CR>"; key = "<leader>fh"; mode = "n"; }
        { action = "<cmd>Telescope buffers<CR>"; key = "<leader>fb"; mode = "n"; }

        # auto-session
        { action = "<cmd>SessionRestore<CR>"; key = "<leader>wr"; mode = "n"; }
        { action = "<cmd>SessionSave<CR>"; key = "<leader>ws"; mode = "n"; }
        { action = "<cmd>SessionDelete<CR>"; key = "<leader>wd"; mode = "n"; }
        { action = "<cmd>SessionPurgeOrphaned<CR>"; key = "<leader>wo"; mode = "n"; }

        # substitute.nvim
        # { action = "require('substitute').operator"; key = "s"; mode = "n"; }
        # { action = "require('substitute').visual"; key = "s"; mode = "x"; }
        # { action = "require('substitute').line"; key = "ss"; mode = "n"; }
        # { action = "require('substitute').eol"; key = "S"; mode = "n"; }

        { action = "<ESC>"; key = "jk"; mode = "i"; }

        { action = "<cmd>nohl<CR>"; key = "<leader>nh"; mode = "n"; }
        
        { action = "<C-a>"; key = "<leader>+"; mode = "n"; }
        { action = "<C-x>"; key = "<leader>-"; mode = "n"; }
        
        { action = "<C-w>v"; key = "<leader>sv"; mode = "n"; }
        { action = "<C-w>s"; key = "<leader>sh"; mode = "n"; }
        { action = "<C-w>="; key = "<leader>se"; mode = "n"; }
        { action = "<cmd>close<CR>"; key = "<leader>sx"; mode = "n"; }

        { action = "<cmd>tabnew<CR>"; key = "<leader>to"; mode = "n"; }
        { action = "<cmd>tabclose<CR>"; key = "<leader>tx"; mode = "n"; }
        { action = "<cmd>tabn<CR>"; key = "<leader>tn"; mode = "n"; }
        { action = "<cmd>tabp<CR>"; key = "<leader>tp"; mode = "n"; }
        { action = "<cmd>tabnew %<CR>"; key = "<leader>tf"; mode = "n"; }
    ];

    plugins = {
        mini = {
            enable = true;
            autoLoad = true;
        };

        alpha = { 
            enable = true;
            theme = "theta";
        };

        auto-session = {
            enable = true;
            autoLoad = true;
        };

        bufferline = {
            enable = true;
            autoLoad = true;
        };

        web-devicons = {
            enable = true;
            autoLoad = true;
            settings = {
                color_icons = true;
                strict = true;
            };
        };

        lualine = {
            enable = true;
            autoLoad = true;
        };

        which-key = {
            enable = true;
            autoLoad = true;
        };

        telescope = {
            enable = true;
            autoLoad = true;
        };

        dressing = {
            enable = true;
            autoLoad = true;
        };

        treesitter = {
            enable = true;
            autoLoad = true;
            grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
                bash
                c
                cpp
                python
                r
                json
                lua
                make
                markdown
                nix
                regex
                toml
                vim
                vimdoc
                xml
                yaml
                ];
        };

        indent-blankline = {
            enable = true;
            autoLoad = true;
        };

        nvim-tree.enable = true;

        nvim-autopairs = {
            enable = true;
            autoLoad = true;
            settings = {
                check_ts = true;
                ts_config = {
                    javascript = [
                        "template_string"
                    ];
                    lua = [
                        "string"
                    ];
                    java = false;
                };
            };
        };

        cmp = {
            enable = true;
            autoLoad = true;
            autoEnableSources = true;
            settings.sources = [
                { name = "nvim_lsp"; }
                { name = "path"; }
                { name = "buffer"; }
            ];
        };

        comment = {
            enable = true;
            autoLoad = true;
        };
    };
    # extraPlugins = with pkgs.vimPlugins; [
    #     {plugin = substitute-nvim;}
    # ];
}