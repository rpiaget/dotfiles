echo "running bashrc..."
## Fix for "Error fetching variable SECRET_ORG_TOKEN_SECRET: open /dev/null: too many open files" when running make instal-secrets
ulimit -Sn 8192

export WEBSITE_DOCROOT="${HOME}/dev/website" # change this to match wherever you cloned this repo.
export DASH_CLIENT_ENV=dev
export MACHINE_ENV=dev
export VHOSTNAME=local.dev.opendns.com

# Docker Compose
USER=$(cat ~/.quadrarc | jq -r '.username')
PASS=$(cat ~/.quadrarc | jq -r '.token')

# Datadog
# alias datadog="sl monitor datadog login --org-id k2fdafqfqt4t8t4d"
alias datadog-knex="sl monitor datadog login --org-id uqib98o49d0pfqhz"


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
export HISTTIMEFORMAT="%d/%m/%y %T "
export LSCOLORS="gxfxexdxcxegedabagacad"

# Paths
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/php@5.6/bin:$PATH"
export PATH="/usr/local/opt/php@5.6/sbin:$PATH"
export PATH="${WEBSITE_DOCROOT}/vendor/bin:${WEBSITE_DOCROOT}/bin:${PATH}"
export PATH="~/.local/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH=/usr/local/opt/gnu-sed/gnubin:/usr/local/opt/coreutils/gnubin:/usr/local/opt/findutils/gnubin:$PATH
export PATH=/usr/local/opt/bash/bin:/Users/ryanpiaget/dev/apache-maven-3.8.2/bin:/Users/ryanpiaget/dev/go/bin:/usr/local/opt/mysql@5.6/bin:~/.local/bin:/Users/ryanpiaget/dev/website/vendor/bin:/Users/ryanpiaget/dev/website/bin:/usr/local/opt/php@5.6/sbin:/usr/local/opt/php@5.6/bin:/usr/local/bin:/Users/ryanpiaget/dev/apache-maven-3.8.2/bin:/Users/ryanpiaget/dev/go/bin:/usr/local/opt/mysql@5.6/bin:~/.local/bin:/Users/ryanpiaget/dev/website/vendor/bin:/Users/ryanpiaget/dev/website/bin:/usr/local/opt/php@5.6/sbin:/usr/local/opt/php@5.6/bin:/usr/local/bin:/Users/ryanpiaget/dev/apache-maven-3.8.2/bin:/Users/ryanpiaget/dev/go/bin:/usr/local/opt/mysql@5.6/bin:~/.local/bin:/Users/ryanpiaget/dev/website/vendor/bin:/Users/ryanpiaget/dev/website/bin:/usr/local/opt/php@5.6/sbin:/usr/local/opt/php@5.6/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt/fzf/bin

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

# Python
export PATH="/Users/ryanpiaget/Library/Python/3.9/bin:$PATH"

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

function website-rebuild() {
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
export API_URL=http://api.local.dev.opendns.com/v3
export APIV3_FIXTURES_VHOST='local.dev.opendns.com'
export APIV3_TOKEN='4B6D025B83D2156C4FAB26C1AADE1846'
export APIV3_KEY='4237E654D1A98ACA7AB52179D2FE3EC4'
export APIV3_USE_TOKEN=true


### OAuth/Umbrella Token
export ACCESS_TOKEN=$(curl -u "$CDFW_CLIENT_ID:$CDFW_CLIENT_SECRET" $KONG_PROXY_API/auth/v2/oauth2/token | jq -r .access_token)
alias getAccessToken="curl -u "$CDFW_CLIENT_ID:$CDFW_CLIENT_SECRET" $KONG_PROXY_API/auth/v2/oauth2/token | jq -r .access_token"

# Misc
alias builddamnit='git commit -m "build damnit" --allow-empty && git push'
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias visudo="EDITOR=vi sudo visudo"

# export GIT_SSH_KEY=$(cat ~/.ssh/id_rsa)

#NVM / Node
export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Hack for setting default node version on new bash start
# nvm use default

### Env
source ~/.env


# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias fzp="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

# Bat
alias man="batman"
alias cat="bat"



if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# source /Users/ryanpiaget/.local/opt/fzf-obc/bin/fzf-obc.bash
