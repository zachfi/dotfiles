source <(kubectl completion zsh)

# function kubectx {
#   if [ -z "$1" ]; then
#     kubectl config get-contexts
#   else
#     kubectl config use-context $1
#   fi
# }

# function kubens {
#   if [[ -z "$1" ]]; then
#     kubectl get ns
#   else
#     kubectl config set-context --current --namespace=$1
#   fi
# }

# source ~/dotfiles/zsh/modules/kubernetes/kubectl_fzf.plugin.zsh

# zplug "plugins/kubectl", from:oh-my-zsh, defer:2
# zplug "bonnefoa/kubectl-fzf", defer:3

export KUBECTL_FZF_OPTIONS=(-1 --header-lines=2 --layout reverse)
export KUBECTL_FZF_OPTIONS=(-1 --header-lines=2 --layout reverse -e)
export KUBECTL_FZF_OPTIONS=(-1 --header-lines=2 --layout reverse -e --no-hscroll --no-sort --bind space:accept)

