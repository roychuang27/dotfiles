let carapace_completer = {|spans: list<string>|
    CARAPACE_LENIENT=1 carapace $spans.0 nushell ...$spans | from json
}

$env.config = ($env.config | merge deep {
    buffer_editor: nvim
    show_banner: short
    cursor_shape: {
      emacs: "blink_line"
    }
    completions: {
        external: {
            enable: true
            completer: $carapace_completer
        }
    }
})

$env.EDITOR = "nvim"
$env.CUDA_DIR = "/opt/cuda/"

let brew_env = ^/home/linuxbrew/.linuxbrew/bin/brew shellenv

use std/util "path add"
path add $"($env.HOME)/.local/bin"
path add $"($env.HOME)/.opencode/bin"

alias vide = neovide
alias ll = ls -la
alias rm = rm -i

def neovide [] {
    ^neovide --fork
}

alias cfhl = nvim ~/.config/hypr/hyprland.lua
alias cffh = nvim ~/.config/fish/config.fish

def ytmdl [...args] {
    let opts = [
        "--extract-audio"
        "--audio-format"
        "opus"
        "--embed-thumbnail"
        "--add-metadata"
        "--embed-metadata"
        "--output"
        "%(playlist)s/%(playlist_index)s - %(artist)s - %(title)s.%(ext)s"
    ]

    ^yt-dlp ...$opts ...$args
}

def --env yz [...args] {
        let tmp = (mktemp -t "yazi-cwd.XXXXXX")
        ^yazi ...$args --cwd-file $tmp
        let cwd = (open $tmp)
        if $cwd != $env.PWD and ($cwd | path exists) {
                cd $cwd
        }
        ^rm -f $tmp
}

source ~/.starship.nu
