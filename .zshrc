# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize propt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias nv="nvim"
alias zr="nv ~/.zshrc"
alias vr="nv ~/.config/nvim/init.lua"
alias tr="nv ~/.tmux.conf"
alias src="exec zsh"
alias x86="arch -x86_64"
alias t="tmux"
alias tt="tmux new -s tropic"
alias pm="cd ~/src/popmenu/"
alias rspec="bundle exec rspec"

alias g="git"
alias gco="git checkout"

export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

. /opt/homebrew/opt/asdf/libexec/asdf.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
