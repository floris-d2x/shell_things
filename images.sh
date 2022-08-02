# AWS / ECR / DOCKER / HELM commands
# This file should be sourced from your .zshrc / .bashrc
# These are POSIX functions, and will not work with fish.
# These functions require that $REPO is set, I.E. REPO=111122223333.dkr.ecr.eu-central-1.amazonaws.com

creds() {
    aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin $REPO
}

hcreds() {
    aws ecr get-login-password --region eu-central-1 | helm registry login --username AWS --password-stdin $REPO
}

dbuild() {
    if [ -z "$1" ]; then
        local tag=latest
    else
        local tag="$1"
    fi

    local wd="${PWD##*/}"
    DOCKER_BUILDKIT=1 docker build --ssh default -t $REPO/$wd:$tag .
}

hbuild() {
    helm package ./chart
}

hpush() {
    local wd="${PWD##*/}"
    helm push $wd-0.1.0.tgz oci://$REPO
}

hlist() {
    local wd="${PWD##*/}"
    aws ecr describe-images --repository-name $wd --region eu-central-1
}

create_repo() {
    local wd="${PWD##*/}"
    printf 'Creating ECR repository '$wd', confirm (y/N)? '
    read -r REPLY
    case $REPLY in [yY]) (aws ecr create-repository --repository-name $wd) ;; esac
}

dpush() {
    if [ -z "$1" ]; then
        local tag=latest
    else
        local tag="$1"
    fi

    local wd="${PWD##*/}"
    printf 'Pushing '$REPO/$wd:$tag', confirm (y/N)? '
    read -r REPLY
    case $REPLY in [yY]) (docker push $REPO/$wd:$tag) ;; esac
}
