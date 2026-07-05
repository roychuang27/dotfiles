source (/usr/bin/starship init fish --print-full-init | psub)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

fish_add_path /home/roychuang/.local/share/gem/ruby/3.4.0/bin/
fish_add_path /home/roychuang/.local/bin
fish_add_path /home/roychuang/.local/share/soar/bin
fish_add_path /opt/android-sdk/platform-tools/
fish_add_path /home/roychuang/.opencode/bin
fish_add_path $HOME/.cargo/bin
set -x CUDA_DIR "/opt/cuda/"

function yy
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
                builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
end

function ytmdl
        yt-dlp --extract-audio --audio-format opus --embed-thumbnail --add-metadata --embed-metadata --output "%(playlist)s/%(playlist_index)s - %(artist)s - %(title)s.%(ext)s" $argv
end

set -gx EDITOR nvim

alias rm='rm -i'
alias vim='nvim'
alias neovide='neovide --fork'
alias vide='neovide'
alias ll='ls -al'

alias cfhl="nvim ~/.config/hypr/hyprland.lua"
alias cffh="nvim ~/.config/fish/config.fish"
