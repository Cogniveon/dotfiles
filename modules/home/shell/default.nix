{
  config,
  lib,
  pkgs,
  ...
}: let
  apply-hm-env = pkgs.writeShellScript "apply-hm-env" ''
    ${lib.optionalString (config.home.sessionPath != []) ''
      export PATH=${builtins.concatStringsSep ":" config.home.sessionPath}:$PATH
    ''}
    ${builtins.concatStringsSep "\n" (lib.mapAttrsToList (k: v: ''
        export ${k}=${v}
      '')
      config.home.sessionVariables)}
    ${config.home.sessionVariablesExtra}
    exec "$@"
  '';

  # runs processes as systemd transient services
  run-as-service = pkgs.writeShellScriptBin "run-as-service" ''
    exec ${pkgs.systemd}/bin/systemd-run \
      --slice=app-manual.slice \
      --property=ExitType=cgroup \
      --user \
      --wait \
      bash -lc "exec ${apply-hm-env} $@"
  '';
in {
  home.packages = with pkgs; [run-as-service comma ripgrep];
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
  programs = {
    nix-index.enable = false;
    exa.enable = true;
    bat.enable = true;
    bat.config.theme = "gruvbox-dark";

    # zoxide = {
    #   enable = true;
    #   enableZshIntegration = true;
    # };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };

    skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };

    starship = {
      enable = true;
      settings = {
        add_newline = false;
        scan_timeout = 5;
        character = {
          error_symbol = "[➜](bold red)";
          success_symbol = "[➜](bold green)";
          vicmd_symbol = "[➜](bold yellow)";
          # format = "$symbol [|](bold bright-black) ";
        };
        git_commit = {commit_hash_length = 4;};
        line_break.disabled = true;
        lua.symbol = "[](blue) ";
        python.symbol = "[](blue) ";
        hostname = {
          ssh_only = true;
          format = "[$hostname](bold blue) ";
          disabled = false;
        };
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      sessionVariables = {
        LC_ALL = "en_US.UTF-8";
        ZSH_AUTOSUGGEST_USE_ASYNC = "true";
        SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      };
      initExtra = ''
        autoload -U compinit
        zstyle ':completion:*' menu select
        zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
        zstyle ':completion:*' completer _complete _match _approximate
        zstyle ':completion:*:match:*' original only
        zstyle ':completion:*:approximate:*' max-errors 1 numeric
        zstyle ':completion:*' sort false
        zstyle ':completion:complete:*:options' sort false
        zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
        zstyle ':completion:*' special-dirs true
        zstyle ':completion:*' rehash true
        zstyle ':completion:*' menu yes select # search
        zstyle ':completion:*' list-grouped false
        zstyle ':completion:*' list-separator '''
        zstyle ':completion:*' group-name '''
        zstyle ':completion:*' verbose yes
        zstyle ':completion:*:matches' group 'yes'
        zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
        zstyle ':completion:*:messages' format '%d'
        zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
        zstyle ':completion:*:descriptions' format '[%d]'
        zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND
        zstyle ':fzf-tab:*' switch-group ',' '.'
        zstyle ':fzf-tab:complete:_zlua:*' query-string input
        zstyle ':fzf-tab:complete:*:*' fzf-preview 'preview.sh $realpath'
        zstyle ":completion:*:git-checkout:*" sort false
        zstyle ':completion:*' file-sort modification
        zstyle ':completion:*:exa' sort false
        zstyle ':completion:files' sort false

        zmodload zsh/complist
        compinit
        _comp_options+=(globdots)
        bindkey '^H' backward-kill-word
        bindkey -M menuselect 'h' vi-backward-char
        bindkey -M menuselect 'k' vi-up-line-or-history
        bindkey -M menuselect 'l' vi-forward-char
        bindkey -M menuselect 'j' vi-down-line-or-history
        bindkey -v '^?' backward-delete-char
        autoload -U url-quote-magic
        # search history based on what's typed in the prompt
        autoload -U history-search-end
        zle -N history-beginning-search-backward-end history-search-end
        zle -N history-beginning-search-forward-end history-search-end
        bindkey "^[OA" history-beginning-search-backward-end
        bindkey "^[OB" history-beginning-search-forward-end
        zle -N self-insert url-quote-magic

        # eval "$(starship init zsh)"

        DIR_POKECOLORSCRIPTS=~/pokemon-colorscripts
        if [ -d "$DIR_POKECOLORSCRIPTS" ] && [ -z "''${VSCODE_SHELL_INTEGRATION+1}" ];
        then
            python3 $DIR_POKECOLORSCRIPTS/pokemon-colorscripts.py -r --no-title
        fi
      '';
      history = {
        save = 500;
        size = 500;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
      };

      shellAliases = with pkgs;
      with lib; {
        rebuild = "sudo nix-store --verify; pushd ~/dotfiles && sudo nixos-rebuild switch --flake .# && notify-send \"Done\"&& bat cache --build; popd";
        cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
        bloat = "nix path-info -Sh /run/current-system";
        ytmp3 = ''
          ${getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';
        cat = "${getExe bat} --style=plain";
        uuid = "cat /proc/sys/kernel/random/uuid";
        grep = getExe ripgrep;
        vim = getExe neovim;
        wget = "wget --hsts-file=\"${config.xdg.dataHome}/wget-hsts\"";
        fzf = getExe skim;
        untar = "tar -xvf";
        untargz = "tar -xzf";
        MANPAGER = "sh -c 'col -bx | bat -l man -p'";
        fcd = "cd $(find -type d | fzf)";
        sc = "sudo systemctl";
        scu = "systemctl --user ";
        ls = "${getExe exa} --color=auto --group-directories-first";
        ll = "${getExe exa} --color=auto --group-directories-first --all --long";
        lt = "${getExe exa} -lah --tree";
        tree = "${getExe exa} --tree";
        httpServer = "${getExe python3} -m http.server";
        diff = "diff --color=auto";
        ".." = "cd ..";
        "..." = "cd ../../";
        "...." = "cd ../../../";
        "....." = "cd ../../../../";
        "......" = "cd ../../../../../";
      };
      plugins = with pkgs; [
        {
          name = "zsh-vi-mode";
          src = zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
    };
  };
}
