let carapace_completer = {|spans: list<string>|
    CARAPACE_LENIENT=1 carapace $spans.0 nushell ...$spans | from json
}

$env.config = ($env.config | merge deep {
        edit_mode: vi
        buffer_editor: nvim
        show_banner: short
        cursor_shape: {
          emacs: line
          vi_insert: line
          vi_normal: block
        }
        completions: {
            external: {
                enable: true
                completer: $carapace_completer
            }
        }
        # hooks: {
        #         pre_prompt: [
        #                 { print -n "\e[ q" }
        #         ]
        # }
        history: {
            file_format: sqlite
            isolation: true
        }
})


$env.EDITOR = "nvim"
$env.CUDA_DIR = "/opt/cuda/"

$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""

use std/util "path add"
path add $"($env.HOME)/.local/bin"
path add $"($env.HOME)/.opencode/bin"
path add "/opt/android-sdk/platform-tools"

alias vide = neovide
alias ll = ls -la
alias rm = rm -i
alias zed = zeditor

def neovide [] {
    ^neovide --fork
}

alias cfnu = config nu
alias acvenv = overlay use .venv/bin/activate.nu
def cfhl [] { ^$env.EDITOR ~/.config/hypr/hyprland.lua }
def rubu [] { sh ~/Projects/dotfiles/pull_from_home.sh }
def cfbu [] { ^$env.EDITOR ~/Projects/dotfiles/watching_files.txt }
def cfkt [] { ^$env.EDITOR ~/.config/kitty/kitty.conf }
def cfnr [] { ^$env.EDITOR ~/.config/niri/config.kdl }
def cfmime [] { ^$env.EDITOR ~/.config/mimeapps.list }
def cfmg [] { ^$env.EDITOR ~/.config/mango/config.conf }

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

def --env y [...args] {
        let tmp = (mktemp -t "yazi-cwd.XXXXXX")
        ^yazi ...$args --cwd-file $tmp
        let cwd = (open $tmp)
        if $cwd != $env.PWD and ($cwd | path exists) {
                cd $cwd
        }
        ^rm -f $tmp
}

# if "TMUX" not-in $env {
#     ^tmux
#     exit
# }

source ~/.starship.nu
source ~/.zoxide.nu
