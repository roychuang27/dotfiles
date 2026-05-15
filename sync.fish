#!/usr/bin/env fish

if not type -q detect-secrets
    echo "Error: detect-secrets is not installed."
    echo "Please run: pip install detect-secrets"
    exit 1
end

set DOTFILES_DIR (cd (dirname (status filename)); and pwd)
echo "Starting dotfiles sync from system to repository..."

set home_files .bash_profile .bashrc .tmux.conf .vimrc
set cp_files .clangd .clang-format
set config_dirs fish kitty nvim

function safe_copy
    set src $argv[1]
    set dest $argv[2]
    
    if not test -e "$src"
        echo "Warning: Source not found: $src (Skipping)"
        return
    end

    echo "Scanning: $src"
    set scan_output (detect-secrets scan "$src" 2>/dev/null)
    if echo "$scan_output" | grep -q '"results": {}'
        rm -rf "$dest"
        cp -r "$src" "$dest"
        echo "Synced: $src -> $dest"
    else
        echo "Error: Potential secrets detected! Blocked copying of: $src"
        echo "Run 'detect-secrets scan $src' for details."
    end
end

echo "--- Processing Home directory files ---"
for f in $home_files
    safe_copy ~/"$f" "$DOTFILES_DIR"/"$f"
end

echo "--- Processing ~/.config directory files ---"
for d in $config_dirs
    safe_copy ~/.config/"$d" "$DOTFILES_DIR"/"$d"
end

echo "--- Processing ~/Projects/cp directory files ---"
for f in $cp_files
    safe_copy ~/Projects/cp/"$f" "$DOTFILES_DIR"/"$f"
end

echo "Sync completed."