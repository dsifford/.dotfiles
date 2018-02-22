#!/usr/bin/env bash
# Responsible for retrieving secure files (certs/keys) from lastpass

command -v lpass >/dev/null || {
    echo 'lastpass-cli must be installed for obtaining private keys and certs.'
    exit 1
}

if [ ! -f ~/.task/freecinc.ca.pem ]; then
    lpass show --notes taskwarrior-ca > ~/.task/freecinc.ca.pem
    lpass show --notes taskwarrior-cert > ~/.task/freecinc.cert.pem
    lpass show --notes taskwarrior-key > ~/.task/freecinc.key.pem
fi
