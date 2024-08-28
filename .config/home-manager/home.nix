{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cherryramatis";
  home.homeDirectory = "/Users/cherryramatis";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ 
      fzf-vim 
      haskell-vim 
      file-line
      vim-sensible
      vim-sleuth
      vim-endwise
      vim-eunuch
      vim-abolish
      vim-vinegar
      vim-commentary
      vim-repeat
      vim-dispatch
      vim-fugitive 
      vim-rhubarb
      vim-unimpaired
      vim-dadbod
      vim-surround
      sideways-vim
      emmet-vim
      vim-visual-multi
    ];
    extraConfig = ''
      filetype plugin on
      syntax on

      set mouse=a
      set hidden
      set nu rnu
      set tw=80
      set tabstop=2
      set shiftwidth=2
      set autoindent
      set expandtab
      set noswapfile
      set completeopt=menu,menuone,noinsert
      set shortmess+=c
      set belloff+=ctrlg
      set splitright splitbelow
      set laststatus=0

      " Eslint format
      set errorformat+=%A%f:%l:%c:%m,%-G%.%#

      if executable('rg')
        set grepprg=rg\ --vimgrep
      endif

      set background=dark
      colorscheme quiet

      inoremap <c-o> <c-x><c-o>
      nnoremap <c-f> <cmd>FZF<cr>
      nnoremap <c-s> <cmd>Rg<cr>

      autocmd FileType fugitive nmap <buffer> cc cvc
      autocmd BufRead *.html setlocal filetype=html.angular

      let g:user_emmet_leader_key = '<C-z>'
      let g:user_emmet_expandabbr_key = '<C-x><C-e>'

      function s:Mkdir()
        let dir = expand('%:p:h')

        if dir =~ '://'
          return
        endif

        if !isdirectory(dir)
          call mkdir(dir, 'p')
          echo 'Created non-existing directory: '.dir
        endif
      endfunction

      autocmd BufWritePre * call s:Mkdir()
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
