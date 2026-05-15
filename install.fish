#!/usr/bin/env fish

set DOTFILES_DIR (cd (dirname (status filename)); and pwd)
echo "Starting dotfiles installation to new system..."

set home_files .bash_profile .bashrc .tmux.conf .vimrc
set cp_files .clangd .clang-format
set config_dirs fish kitty nvim

mkdir -p ~/.config
mkdir -p ~/Projects/cp

function deploy_with_backup
    set src $argv[1]
    set dest $argv[2]

    if not test -e "$src"
        echo "Warning: Source file not found in repository: $src (Skipping)"
        return
    end

    if test -e "$dest"
        set backup_name "$dest.bak_"(date +%Y%m%d_%H%M%S)
        mv "$dest" "$backup_name"
        echo "Backed up existing file: $dest -> $backup_name"
    end

    cp -r "$src" "$dest"
    echo "Deployed: $dest"
end

echo "--- Deploying Home directory files ---"
for f in $home_files
    deploy_with_backup "$DOTFILES_DIR"/"$f" ~/"$f"
end

echo "--- Deploying ~/.config directory files ---"
for d in $config_dirs
    deploy_with_backup "$DOTFILES_DIR"/"$d" ~/.config/"$d"
end

echo "--- Deploying ~/Projects/cp directory files ---"
for f in $cp_files
    deploy_with_backup "$DOTFILES_DIR"/"$f" ~/Projects/cp/"$f"
end

echo "Installation completed."
