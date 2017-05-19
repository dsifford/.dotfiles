__from_exercism_config() {
  COMPREPLY=()
  local cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=($(compgen -W 'demo debug configure fetch restore submit unsubmit tracks download help' -- $cur))
}
 
complete -F __from_exercism_config -o default exercism
