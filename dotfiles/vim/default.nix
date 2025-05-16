{ pkgs, lib, config, ...}:

with lib; let
in {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
#    plugins = with pkgs.vimPlugins; [
#      vim-nix
#    ];
    extraConfig = ''
      set clipboard^=unnamed,unnamedplus  " clipboard
      set number                          " line nums
      set nocompatible                    " disable vi compat
      set ignorecase                      " case insensitive search
      set mouse=v                         " middle-click paste
      set hlsearch                        " highlight search
      set incsearch                       " incremental search
      set tabstop=2                       " tab length     
      set softtabstop=2                   " see spaces as tabs
      set expandtab                       " convert tabs to spaces
      set autoindent                      " auto indent
      set wildmode=longest,list           " tab completion
      filetype plugin indent on           " auto indent
      syntax on                           " syntax HLing
      set mouse=a                         " enable mouse click
      filetype plugin on                  " uhh I forget
      set cursorline                      " HL current cursorline
      set ttyfast                         " fast scrolling
      set cursorline                      " tab HLs
      "set cursorcolumn                    " tab HLs
      set list                            " tab HLs
      set listchars=tab:\|\               " tab HLs
      set foldmethod=marker               " idk
      set smartcase                       " searches are case-inensitive
      nnoremap <C-@> :call system("wl-copy", @")<CR>

    '';
  };
}
