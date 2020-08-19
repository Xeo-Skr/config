set fish_greeting

alias vi="nvim"
alias vim="nvim"
alias v="nvim"

alias ll="ls -la $argv"
alias l="ls -lAa $argv"

fish_vi_key_bindings

function fish_user_key_bindings
    # Still enable ctrl+f in Vim mode
    for mode in insert default visual
      bind -M $mode \cf forward-char
		end
end

set -gx EDITOR nvim

set -gx EPITECH_PATH "$HOME/Documents/epitech"
set -gx PATH $HOME/.config/scripts $PATH
set -g fish_user_paths "/usr/local/opt/qt/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/qt/bin" $fish_user_paths

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/xeoskr/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/xeoskr/Downloads/google-cloud-sdk/path.fish.inc'; end
