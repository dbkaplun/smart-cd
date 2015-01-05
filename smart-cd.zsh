#!/usr/bin/env zsh

[ ! -n "${SMART_CD_LS+1}" ] && SMART_CD_LS=true
[ ! -n "${SMART_CD_GIT_STATUS+1}" ] && SMART_CD_GIT_STATUS=true

_lastgitdir=''
chpwd () {
  emulate -L zsh

  [[ $SMART_CD_LS == true ]] && ls -A

  if [[ $SMART_CD_GIT_STATUS == true ]]; then
    local gitdir="$(git rev-parse --git-dir 2>/dev/null)"
    if [[ -n "$gitdir" ]]; then
      gitdir="$gitdir:A" # absolute path of $gitdir
      [[ "$gitdir" != "$_lastgitdir" ]] && (echo; git status)
      _lastgitdir="$gitdir"
    fi
  fi
}
chpwd
