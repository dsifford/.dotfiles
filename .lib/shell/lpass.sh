#!/usr/bin/env bash
# Responsible for retrieving secure files (certs/keys) from lastpass

taskdata_dir="$XDG_DATA_HOME/task"

command -v lpass >/dev/null || {
    echo 'lastpass-cli must be installed for obtaining private keys and certs.'
    exit 1
}

[[ -d $taskdata_dir ]] || {
	echo "'\$XDG_DATA_HOME/task' directory not found"
	exit 1
}

if [[ ! -f $taskdata_dir/freecinc.ca.pem ]]; then
    lpass show --notes taskwarrior-ca > "$taskdata_dir"/freecinc.ca.pem
    lpass show --notes taskwarrior-cert > "$taskdata_dir"/freecinc.cert.pem
    lpass show --notes taskwarrior-key > "$taskdata_dir"/freecinc.key.pem
fi
