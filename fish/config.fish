source (/usr/bin/starship init fish --print-full-init | psub)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

set -x PATH "/home/roychuang/.local/bin/statusbar /home/roychuang/.local/share/gem/ruby/3.4.0/bin/" $PATH 
set -x PATH "/home/roychuang/.local/bin /home/roychuang/.local/share/soar/bin" $PATH 
set -x PATH "/opt/android-sdk/platform-tools/" $PATH 
set -x CUDA_DIR "/opt/cuda/"


function yy
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

function vim
	nvim $argv
end

function rm
	rm -i %argv
end

function vide
	neovide --fork $argv
end

# opencode
fish_add_path /home/roychuang/.opencode/bin
