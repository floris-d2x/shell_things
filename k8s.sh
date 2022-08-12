#! /bin/echo Source this file instead of running it

# kubectl commands and aliases
# This file should be sourced from your .zshrc / .bashrc
# These are POSIX functions, and will not work with fish.
# These functions expect that $NAMESPACE is set

# kubectl aliases
alias k=kubectl
alias kd="kubectl delete -f"
alias ka="kubectl apply -f"
alias kgp="kubectl get pods"
alias kgs="kubectl get svc"
alias kgn="kubectl get nodes"
alias wkgp="watch kubectl get pods"
alias wkgs="watch kubectl get svc"
alias wkgn="watch kubectl get nodes"
alias kl="kubectl logs"
alias wkl="watch kubectl logs"
alias kdp="kubectl describe pod"

ksh() { 
kubectl exec -it "$1" -- /bin/bash 
}

kcp() {
case $1 in
    -n | --namespace)
        shift
        NAMESPACE=$1
        shift
        ;;
esac
    kubectl cp $NAMESPACE/"$1":"$2" "$3"
}

kubens() {
    if [ -z "$1" ]; then
        printf 'No namespace provided, switching to default\n'
        NAMESPACE=default
    else
        printf 'Switching to namespace '$1'\n'
        NAMESPACE=$1
    fi
        kubectl config set-context --current --namespace="$NAMESPACE" > /dev/null
}
