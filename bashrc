## Fix for "Error fetching variable SECRET_ORG_TOKEN_SECRET: open /dev/null: too many open files" when running make instal-secrets
ulimit -Sn 8192

export WEBSITE_DOCROOT="${HOME}/dev/website" # change this to match wherever you cloned this repo.
export DASH_CLIENT_ENV=dev
export MACHINE_ENV=dev
export VHOSTNAME=local.dev.opendns.com

## Git Completions
source ~/bin/git-completion.bash

# VirtualEnv
export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/Dropbox/Projects
export PROJECT_HOME=$HOME/dev
source /usr/local/bin/virtualenvwrapper.sh

# Brain (these don't seem to load properly...)
export SECRET_BRAIN_SSL_CERT="-----BEGIN CERTIFICATE-----
MIID/TCCAuWgAwIBAgIJAJIkg2uh8mXhMA0GCSqGSIb3DQEBCwUAMIGEMQswCQYD
VQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5j
aXNjbzEWMBQGA1UECgwNT3BlbkROUywgSW5jLjEPMA0GA1UECwwGQnJhaW4zMR8w
HQYDVQQDDBZCcmFpbjMgT3BlbkROUyBSb290IENBMB4XDTE1MDQyMTE4MTg0MFoX
DTI1MDQxODE4MTg0MFowgYQxCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9y
bmlhMRYwFAYDVQQHDA1TYW4gRnJhbmNpc2NvMRYwFAYDVQQKDA1PcGVuRE5TLCBJ
bmMuMQ8wDQYDVQQLDAZCcmFpbjMxHzAdBgNVBAMMFkJyYWluMyBPcGVuRE5TIFJv
b3QgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDTk3blcbvd2K7l
H7j8lbl8eLq53kqJxrjIV1J2dh8UyweGKeoRfWB94b47xHA9rawMXeUFtNuFRROr
QW5oDSZpjjX02PA+lZoJpVIXICDp3+PBiCGKNJ4haTEwUDZz3Gybpgu1wpqy/1v5
6Ag9tnx7vZrwIXJxzG92zrQRMNdpECPdTd37XHtIbwhVZ7P+dmGXjD4Vj5SJ3p6M
JjgFf65ZC9u7F9FLkn168LgP8U87v62j3D4E+LHr4TVIl8j8egeK6qCrZJUVu4ww
WTRnyKQqcDe5Kg9+x+SYJC35GcF2MzWLosOsPX2+kfsleI0XtzkzQKTc/fGobHXq
QOGpeZYxAgMBAAGjcDBuMB0GA1UdDgQWBBTWXMLe1femnd+Gz0jwVPRmOlF1kzAf
BgNVHSMEGDAWgBTWXMLe1femnd+Gz0jwVPRmOlF1kzAMBgNVHRMEBTADAQH/MAsG
A1UdDwQEAwIBhjARBglghkgBhvhCAQEEBAMCAQYwDQYJKoZIhvcNAQELBQADggEB
AFBlwaIu0vF1KR/Q5gYxaI9AYd4GST3m/uVKeuF2H9Uw0aCaOO5DdMbdCFng33QF
BD2GpwznuJ3C+MXSdInhJwaae+fjM57RGLV/79wuLTZCqHaqRBMFOtzWi1Qa4NUv
IlFcAXEKb/qJ6JdRC4rZhM/6V+VNr6VQaU5ZzHmIiWfaCE5EwuWgr+9c46W75eqU
hCC+4RxHdD9Bf2kjgMm1U+VeE6Mp+vzMjR+f8IFKc9miPvbW+ep6rgV1XyYAomGi
lc0JtljZX01MqM5bA1Onue/3qNsKcBS1mmcf43TTp/SXBEN0ShUcC1uVtZBKMhI0
1BroptS+UtKAaLZQgxiurmE=
-----END CERTIFICATE-----"
export SECRET_BRAIN_API_TOKEN="3DB1C62950384915AEAB7E1A97E36FAB"

# Docker
alias dc="docker container"
alias dcup="docker-compose -f docker-compose.yml -f docker-compose74.yml up -dV"


# Docker Compose
USER=$(cat ~/.quadrarc | jq -r '.username')
PASS=$(cat ~/.quadrarc | jq -r '.token')
# echo ${PASS} | docker login images.quadra.opendns.com -u ${USER} --password-stdin

# Datadog
alias datadog="sl monitor datadog login --org-id k2fdafqfqt4t8t4d"


# Useful Command Line Stuff
alias ll='ls -lhGAF'
alias ls='ls -GAF'
alias path='echo -e ${PATH//:/\n}'
alias path='echo $PATH'
alias ..='cd ..'

# Z
. /usr/local/etc/profile.d/z.sh

### Editor ###
export EDITOR="sublime -w"

## Terminal Formatting
export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \w\[\033[0;33;1m\] - [$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;33;1m\]]\[\033[0m\033[0;32;1m\] \$\[\033[0m\033[0;32;1m\]\[\033[0m\] '
# export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \w\[\033[0;33;1m\] - [$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;33;1m\]]\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\]\[\033[0m\] '
export HISTTIMEFORMAT="%d/%m/%y %T "
export LSCOLORS="gxfxexdxcxegedabagacad"

# Paths
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/php@5.6/bin:$PATH"
export PATH="/usr/local/opt/php@5.6/sbin:$PATH"
export PATH="${WEBSITE_DOCROOT}/vendor/bin:${WEBSITE_DOCROOT}/bin:${PATH}"
export PATH="~/.local/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"


# Golang
export GOPATH="$HOME/dev/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"
export GOMODULE111="on"
alias switch-gopath-to-work="export GOPATH=/Users/rpiaget/dev/go"
alias switch-gopath-to-personal="export GOPATH=/Users/rpiaget/Dropbox/Projects/Exercism/go"
alias swagger="docker run --rm -it  --user $(id -u):$(id -g) -e GOPATH=$HOME/go:/go -v $HOME:$HOME -w $(pwd) quay.io/goswagger/swagger"

# Java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_92.jdk/Contents/Home"
export PATH="$HOME/dev/apache-maven-3.8.2/bin:$PATH"

### KNEX ###
# streamline and docker functions
export STRLN_AUTH=true
function sllogin() {
    OUTPUT=$(sl aws session generate --account-id ${ACCOUNT_ID} --role-name ${ROLE})
    URL=$(echo "${OUTPUT}" | grep 'signin.aws.amazon.com')
    if [[ "$URL" == "" ]]; then
        echo "$OUTPUT"
    else
        open "${URL}"
    fi
}

function website-secrets() {
    ulimit -Sn 4096
    sl iam token refresh
    sl aws session generate --account-id 536665735667 --role-name dashweb-aws-dev-secrets-access --profile dashweb-aws-dev-secrets-access --region us-west-2 && export AWS_PROFILE="dashweb-aws-dev-secrets-access" && export AWS_REGION="us-west-2"
    make install-secrets
}

function website-pull() {
    docker-compose down
    $(sl container registry auth generate)
    docker-compose pull
}

website-rebuild() {
   website-secrets
    website-pull
    bin/dockerized build make composer
    bin/dockerized easydev make dash-build
}

alias cdfw-aws="ROLE=owner ACCOUNT_ID=304825482992 sllogin"
alias slu="sl upgrade"
# alias website-secrets="ROLE=dashweb-aws-dev-secrets-access ACCOUNT_ID=536665735667 sllogin"
alias website-secrets="website-secrets"
alias website-rebuild="website-rebuild"

function sll() {
    sl iam token refresh || sl login --username $USER@cisco.com

    eval $(sl container registry auth generate)
}

### Local DB ###
alias mysql-local="mysql -u accounts_dev -pdevelopment -h 127.0.0.1 accounts"

### APIv3 ###
export APIV3_ENDPOINT=http://api.local.dev.opendns.com/v3 # typically this localhost address
export APIV3_TOKEN='4B6D025B83D2156C4FAB26C1AADE1846'
export APIV3_KEY='4237E654D1A98ACA7AB52179D2FE3EC4'

### OAuth/Umbrella Token
export ACCESS_TOKEN=$(curl -u "$CDFW_CLIENT_ID:$CDFW_CLIENT_SECRET" $KONG_PROXY_API/auth/v2/oauth2/token | jq -r .access_token)
alias getAccessToken="curl -u "$CDFW_CLIENT_ID:$CDFW_CLIENT_SECRET" $KONG_PROXY_API/auth/v2/oauth2/token | jq -r .access_token"

# Misc
alias builddamnit='git commit -m "build damnit" --allow-empty && git push'
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias visudo="EDITOR=vi sudo visudo"

export GIT_SSH_KEY=$(cat ~/.ssh/id_rsa)

#NVM / Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Hack for setting default node version on new bash start
nvm use default

### Env
source ~/.env


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
