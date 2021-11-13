## Fix for "Error fetching variable SECRET_ORG_TOKEN_SECRET: open /dev/null: too many open files" when running make instal-secrets
ulimit -Sn 8192

## For using vagrant VM as a testing target
export WEBSITE_DOCROOT="${HOME}/dev/website" # change this to match wherever you cloned this repo.
export DASH_CLIENT_ENV=dev
export MACHINE_ENV=dev
export VHOSTNAME=local.dev.opendns.com

## For using vagrant with local db
# export LOCAL_MYSQL=true
# export DEV_DB_MAIN_HOST=172.27.72.27
# export DEV_DB_AUDITLOG_HOST=172.27.72.27

## Git Completions
source ~/bin/git-completion.bash

# VirtualEnv
export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/Dropbox/Projects
export PROJECT_HOME=$HOME/dev
source /usr/local/bin/virtualenvwrapper.sh

# Vinz
export VINZ_USERNAME="rpiaget"
export VINZ_PASSWORD="Tqbfj0tld"

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

# Docker Compose
USER=$(cat ~/.quadrarc | jq -r '.username')
PASS=$(cat ~/.quadrarc | jq -r '.token')
# echo ${PASS} | docker login images.quadra.opendns.com -u ${USER} --password-stdin

# AWS
alias p1="sl aws session generate --role-name engineer --account-id 067346688434 --region us-west-1"
alias d1="sl aws session generate --role-name engineer --account-id 522072180890 --region us-west-1"
alias e1="sl aws session generate --role-name engineer --account-id 711911407174 --region us-west-1"
alias hydra-prod-enginer="sl aws session generate --role-name engineer --account-id 018084539391"
alias hydra-prod-owner="sl aws session generate --role-name owner --account-id 018084539391"
alias hydra-stage-enginer="sl aws session generate --role-name engineer --account-id 533633153805"
alias hydra-stage-owner="sl aws session generate --role-name owner --account-id 533633153805"

function sllogin() {
    OUTPUT=$(sl aws session generate --account-id ${ACCOUNT_ID} --role-name ${ROLE})
    URL=$(echo "${OUTPUT}" | grep 'signin.aws.amazon.com')
    if [[ "$URL" == "" ]]; then
        echo "$OUTPUT"
    else
        open "${URL}"
    fi
}

alias cdfw-aws="ROLE=owner ACCOUNT_ID=304825482992 sllogin"
alias slu="sl upgrade"

# Streamline
alias datadog="sl monitor datadog login --org-id k2fdafqfqt4t8t4d"
export STRLN_AUTH=true


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
export GOMODULE111=off
alias switch-gopath-to-work="export GOPATH=/Users/rpiaget/dev/go"
alias switch-gopath-to-personal="export GOPATH=/Users/rpiaget/Dropbox/Projects/Exercism/go"
alias swagger="docker run --rm -it  --user $(id -u):$(id -g) -e GOPATH=$HOME/go:/go -v $HOME:$HOME -w $(pwd) quay.io/goswagger/swagger"

# Java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_92.jdk/Contents/Home"
export PATH="$HOME/dev/apache-maven-3.8.2/bin:$PATH"

### KNEX ###
# streamline and docker functions
function sllogin() {
    OUTPUT=$(sl aws session generate --account-id ${ACCOUNT_ID} --role-name ${ROLE})
    URL=$(echo "${OUTPUT}" | grep 'signin.aws.amazon.com')
    if [[ "$URL" == "" ]]; then
        echo "$OUTPUT"
    else
        open "${URL}"
    fi
}

alias cdfw-aws="ROLE=owner ACCOUNT_ID=304825482992 sllogin"
alias slu="sl upgrade"

function sll() {
    sl iam token refresh || sl login --username $USER@cisco.com

    eval $(sl container registry auth generate)
}
###

# Misc
alias builddamnit='git commit -m "build damnit" --allow-empty && git push'
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias visudo="EDITOR=vi sudo visudo"
alias upload-migration-file-to-m48="scp migration.json root@m48.sjc.opendns.com:/root/rpiaget/"

export GIT_SSH_KEY=$(cat ~/.ssh/id_rsa)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
