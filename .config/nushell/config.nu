let carapace_completer = {|spans|
    let result = (
        do {
            CARAPACE_LENIENT=1 carapace $spans.0 nushell ...$spans
            | complete
        }
    )

    if $result.exit_code != 0 {
        return null
    }

    let output = ($result.stdout | str trim)

    if ($output | is-empty) {
        return null
    }

    let completions = (
        $output
        | from json
    )

    if ($completions | is-empty) {
        null
    } else {
        $completions
    }
}

$env.config = ($env.config | merge deep {
        edit_mode: helix
        buffer_editor: helix
        show_banner: short
        cursor_shape: {
          emacs: line
          vi_insert: line
          vi_normal: block
          helix_normal: block
          helix_insert: line
        
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

$env.EDITOR = "helix"
$env.CUDA_DIR = "/opt/cuda/"

$env.CC = "/usr/bin/clang"
$env.CXX = "/usr/bin/clang++"

$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""

$env.config.highlight_resolved_externals = true
$env.config.color_config.shape_internalcall = "cyan_bold"
$env.config.color_config.shape_external_resolved = "green_bold"
$env.config.color_config.shape_external = "red_bold"

$env.config.color_config.shape_garbage = {
    fg: "white"
    bg: "red"
    attr: "b"
}

use std/util "path add"
path add $"($env.HOME)/.local/bin"
path add $"($env.HOME)/.opencode/bin"
path add "/opt/android-sdk/platform-tools"
path add $"($env.HOME)/.cargo/bin"
path add $"($env.HOME)/go/"
path add $"($env.HOME)/go/bin/"

alias vide = neovide
alias ll = ls -la
alias rm = rm -i
alias zed = zeditor
alias hx = helix
alias cocom = cocom -d

def neovide [] {
    ^neovide --fork
}

alias acvenv = overlay use .venv/bin/activate.nu

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

source ~/.local/share/scripts/starship.nu
source ~/.local/share/scripts/zoxide.nu


