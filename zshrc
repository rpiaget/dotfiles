[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Terminal Formatting
export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \w\[\033[0;33;1m\] - [$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;33;1m\]]\[\033[0m\033[0;32;1m\] \$\[\033[0m\033[0;32;1m\]\[\033[0m\] '
export HISTTIMEFORMAT="%d/%m/%y %T "
export LSCOLORS="gxfxexdxcxegedabagacad"

# Useful Command Line Stuff
alias ll='ls -lhGAF'
alias ls='ls -GAF'
alias path='echo -e ${PATH//:/\n}'
alias path='echo $PATH'
alias ..='cd ..'

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