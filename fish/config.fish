source (/usr/bin/starship init fish --print-full-init | psub)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

set -x PATH "/home/roychuang/.local/bin/statusbar " $PATH 
fish_add_path /home/roychuang/.local/share/gem/ruby/3.4.0/bin/
fish_add_path /home/roychuang/.local/bin
fish_add_path /home/roychuang/.local/share/soar/bin
fish_add_path /opt/android-sdk/platform-tools/
set -x CUDA_DIR "/opt/cuda/"


function yy
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

alias rm='rm -i'
alias vim='nvim'
alias neovide='neovide --fork'
alias vide='neovide'
alias ll='ls -al'

# opencode
fish_add_path /home/roychuang/.opencode/bin
