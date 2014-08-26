#!/bin/bash

# most alias' configured via .gitconfig

alias g="git"
alias undopush="git push -f origin HEAD^:master"

# open all changed files (that still actually exist) in the editor
function ged() {
  local files=()
  for f in $(git diff --name-only "$@"); do
    [[ -e "$f" ]] && files=("${files[@]}" "$f")
  done
  local n=${#files[@]}
  echo "Opening $n $([[ "$@" ]] || echo "modified ")file$([[ $n != 1 ]] && \
    echo s)${@:+ modified in }$@"
  subl "${files[@]}"
}

# GitHub URL for current repo.
function gurl() {
  local remotename="${@:-origin}"
  local remote="$(git remote -v | awk '/^'"$remotename"'.*\(push\)$/ {print $2}')"
  [[ "$remote" ]] || return
  local user_repo="$(echo "$remote" | perl -pe 's/.*://;s/\.git$//')"
  echo "https://github.com/$user_repo"
}
# Current Branch or SHA if detatched
alias gbs='git branch | perl -ne '"'"'/^\* (?:\(detached from (.*)\)|(.*))/ && print "$1$2"'"'"''
# GitHub URL for current repo, including current branch + path.
alias gurlp='echo $(gurl)/tree/$(gbs)/$(git rev-parse --show-prefix)'

# git log with per-commit cmd-clickable GitHub URLs (iTerm)
function gf() {
  git log $* --name-status --color | awk "$(cat <<AWK
    /^.*commit [0-9a-f]{40}/ {sha=substr(\$2,1,7)}
    /^[MA]\t/ {printf "%s\t$(gurl)/blob/%s/%s\n", \$1, sha, \$2; next}
    /.*/ {print \$0}
AWK
  )" | less -F
}

# open last commit in GitHub, in the browser.
function gfu() {
  local n="${@:-1}"
  n=$((n-1))
  git web--browse  $(git log -n 1 --skip=$n --pretty=oneline | awk "{printf \"$(gurl)/commit/%s\", substr(\$1,1,7)}")
}
# open current branch + path in GitHub, in the browser.
alias gpu='git web--browse $(gurlp)'


# Created by Sindre Sorhus
# Magically retrieves a GitHub users email even though it's not publicly shown
function git_user_email() {
  [ "$1" = "" ] && echo "usage: $0 <GitHub username> [<repo>]" && exit 1

  [ "$2" = "" ] && repo=`curl "https://api.github.com/users/$1/repos?type=owner&sort=updated" -s | sed -En 's|"name": "(.+)",|\1|p' | tr -d ' ' | head -n 1` || repo=$2

  curl "https://api.github.com/repos/$1/$repo/commits" -s | sed -En 's|"(email\|name)": "(.+)",?|\2|p' | tr -s ' ' | paste - - | sort -u -k 1,1
  # `paste - -`      remove every other linebreak
  # `sort -u -k1,1`  only show unique lines based on first column (email)
}

# take this repo and copy it to somewhere else minus the .git stuff.
function gitexport(){
  mkdir -p "$1"
  git archive master | tar -x -C "$1"
}

