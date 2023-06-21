### Version Control ###
autoload -Uz vcs_info
precmd() { vcs_info }

### Terminal Formatting ###
# Setup Git branch details
zstyle ':vcs_info:git:*' formats '%b' # Source: https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html

zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

setopt PROMPT_SUBST
PROMPT='%F{green}%n%f %F{cyan}@ %~%f %F{226}- [${vcs_info_msg_0_}]%f %F{green}$%f '
export LSCOLORS="gxfxexdxcxegedabagacad" # See this LS Colors tool to create a theme https://geoff.greer.fm/lscolors/

### Env ###
source ~/.env

### Path ### Todo - separate this out into chunks
export PATH="$GOPATH/bin:/Users/ryanpiaget/.nvm/versions/node/v12.14.1/bin:/Users/ryanpiaget/Library/Python/3.9/bin:/Users/ryanpiaget/dev/apache-maven-3.8.2/bin:/Users/ryanpiaget/go:/Users/ryanpiaget/go/bin:/usr/local/opt/bash/bin:/Users/ryanpiaget/dev/apache-maven-3.8.2/bin:/usr/local/opt/mysql@5.6/bin:/Users/ryanpiaget/.local/bin:/Users/ryanpiaget/dev/website/vendor/bin:/Users/ryanpiaget/dev/website/bin:/usr/local/opt/php@5.6/sbin:/usr/local/opt/php@5.6/bin:/usr/local/bin:/Users/ryanpiaget/dev/apache-maven-3.8.2/bin:/usr/local/opt/mysql@5.6/bin:/Users/ryanpiaget/.local/bin:/Users/ryanpiaget/dev/website/vendor/bin:/Users/ryanpiaget/dev/website/bin:/usr/local/opt/php@5.6/sbin:/usr/local/opt/php@5.6/bin:/usr/local/bin:/Users/ryanpiaget/dev/apache-maven-3.8.2/bin:/usr/local/opt/mysql@5.6/bin:/Users/ryanpiaget/.local/bin:/Users/ryanpiaget/dev/website/vendor/bin:/Users/ryanpiaget/dev/website/bin:/usr/local/opt/php@5.6/sbin:/usr/local/opt/php@5.6/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt/fzf/bin"

### Local Website ###
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

alias website-secrets="website-secrets"
alias website-rebuild="website-rebuild"

### Local Website MySQL DB ###
alias mysql-local="mysql -u accounts_dev -pdevelopment -h 127.0.0.1 accounts"

### Local Website APIv3 ###
export APIV3_ENDPOINT=http://api.local.dev.opendns.com/v3 # typically this localhost address
export API_URL=http://api.local.dev.opendns.com/v3
export APIV3_FIXTURES_VHOST='local.dev.opendns.com'
export APIV3_TOKEN='4B6D025B83D2156C4FAB26C1AADE1846'
export APIV3_KEY='4237E654D1A98ACA7AB52179D2FE3EC4'
export APIV3_USE_TOKEN=true

### KNEX AWS Streamline ###
alias slu="sl upgrade"
alias cdfw-aws="ROLE=owner ACCOUNT_ID=304825482992 sllogin"
alias app-connector-aws="ROLE=engineer ACCOUNT_ID=097151423082 sllogin"

### Datadog ###
alias datadog-knex="sl monitor datadog login --org-id uqib98o49d0pfqhz"

### Quadra ###
export USER=$(cat ~/.quadrarc | jq -r '.username')
export PASS=$(cat ~/.quadrarc | jq -r '.token')

### OAuth/Umbrella Token ###
export ACCESS_TOKEN=$(curl -u "$CDFW_CLIENT_ID:$CDFW_CLIENT_SECRET" $KONG_PROXY_API/auth/v2/oauth2/token | jq -r .access_token)
alias getUmbrellaAccessToken="curl -u "$CDFW_CLIENT_ID:$CDFW_CLIENT_SECRET" $KONG_PROXY_API/auth/v2/oauth2/token | jq -r .access_token"

### ZTNA Config Producer ###
# export ZTNA_PRODUCER_JWT=
alias getZTNAConfigProducerAccessTokenStage="curl -u "$ZTNA_CONFIG_PRODUCER_CLIENT_ID_STAGE:$ZTNA_CONFIG_PRODUCER_CLIENT_SECRET_STAGE" $KONG_PROXY_API_STAGE/auth/v2/oauth2/token | jq -r .access_token"
alias getTunnelConfigAccessTokenStage="curl -u "$TUNNEL_CONFIG_ID_STAGE:$TUNNEL_CONFIG_SECRET_STAGE" $KONG_PROXY_API_STAGE/auth/v2/oauth2/token | jq -r .access_token"

alias getZTNAConfigProducerAccessTokenProd="curl -u "$ZTNA_CONFIG_PRODUCER_CLIENT_ID_PROD:$ZTNA_CONFIG_PRODUCER_CLIENT_SECRET_PROD" $KONG_PROXY_API/auth/v2/oauth2/token | jq -r .access_token"

### NVM / Node
export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh

### Useful Command Line Stuff ###
alias ll='ls -lhGAF'
alias ls='ls -GAF'
alias path="echo $PATH | tr ':' '\n'"
alias ..='cd ..'
alias sortedenv="env | sort"
alias se="sortedenv"

### FZF ###
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias fzp="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

### Bat ###
alias man="batman"
alias cat="bat"

### Z (Jump Around) ###
. $(brew --prefix)/etc/profile.d/z.sh

### Golang ###
export GOPATH="$HOME/go"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
