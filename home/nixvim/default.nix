{ config, lib, pkgs, ... }:

{
   programs.nixvim = {
    enable = true;

    colorschemes.catppuccin = {
      enable = true;
      flavour = "latte";
      transparentBackground = true;
    };

    highlight = { Normal.bg = "none"; };

    globals = {
      mapleader = " ";
    };

    keymaps = [
      {
          key = "<leader>ff";
          action = "<cmd>Ex<CR>";
      }
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
      }
    ];

    options = {
      expandtab = true;
      shiftwidth = 4;
      smartindent = true;
      tabstop = 4;
      number = true;
      relativenumber = true;
      incsearch = true;
      scrolloff = 3;
      textwidth = 100;
      cursorline = true;
      title = true;
      termguicolors = true;
      background = "light";
      showmode = false;
    };

    plugins = {
      nix.enable = true;

      lsp = {
        enable = true;

        servers = {
          clangd.enable = true;
          gopls.enable = true;
          rust-analyzer.enable = true;
          hls.enable = true;

          nil_ls = {
            enable = true;
            settings = {
              formatting.command = [ "nixpkgs-fmt" ];
            };
          };
        };

        keymaps = {
          diagnostic = {
            "<space>e" = "open_float";
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<space>q" = "setloclist";
          };

          lspBuf = {
            K = "hover";
            gD = "declaration";
            gd = "definition";
            gi = "implementation";
            gr = "references";
            "<C-k>" = "signature_help";
            "<space>wa" = "add_workspace_folder";
            "<space>wr" = "remove_workspace_folder";
            #"<space>wl" = ''
            #  function()
            #    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            #  end;
            #'';
            "<space>D" = "type_definition";
            "<space>rn" = "rename";
            "<space>ca" = "code_action";
            "<space>f" = "format";
          };
        };
      };

      nvim-cmp = {
        enable = true;

        snippet.expand = "luasnip";

        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "treesitter"; }
        ];

        mapping = {
          "<CR>" = "cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace }";
          "<Tab>" = {
            modes = [ "i" "s" ];
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require'luasnip'.expand_or_jumpable() then
                  require'luasnip'.expand_or_jump()
                else
                  fallback()
                end
              end
            '';
          };
          "<S-Tab>" = {
            modes = [ "i" "s" ];
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require'luasnip'.jumpable(-1) then
                  require'luasnip'.jump(-1)
                else
                  fallback()
                end
              end
            '';
          };
          "<C-e>" = "cmp.mapping.abort()";
          "<C-Space>" = "cmp.mapping.complete";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f" = "cmp.mapping.scroll_docs(4)";
        };
      };

      luasnip.enable = true;
      treesitter.enable = true;
      gitsigns.enable = true;
      nvim-autopairs.enable = true;
      illuminate.enable = true;
    };
  };
}

