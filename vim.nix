{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    package = (pkgs.vim-full.override { }).customize{
        name = "vim";
        vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
          start = [ vim-nix everforest ];
          opt   = [];
        };
        vimrcConfig.customRC = ''
          source $VIMRUNTIME/defaults.vim
          syntax on
          set tabstop=2 shiftwidth=2 expandtab
          set ruler
          set showcmd
          set history=50
          set number numberwidth=4
          set background=dark
          set hlsearch 
          highlight LineNr ctermfg=grey
          filetype indent on
          let g:everforest_background='soft'
          let g:everforest_better_performance=1
          let g:everforest_enable_italics=1
          colorscheme everforest
        '';
      };
  };
}
