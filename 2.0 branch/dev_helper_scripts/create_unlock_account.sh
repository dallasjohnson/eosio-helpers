#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/common.sh

if [[ $# -lt 1 ]]; then
  color_printf "Error expected arguments\nUsage: $0 ACCOUNT_NAME"
  exit 1
fi

ACCOUNT_NAME=$1

color_printf "Unlock the default wallet: "

exe eosioc wallet unlock --password PW5JrK9LULdD5khPSAvkKy1TuCxmdfbjPfTk4gjaN5opDz5bdodK1 # password from creating a wallet using `eosioc wallet create`

color_printf "List the current keys:"
exe eosioc wallet keys
pause

color_printf "If it's currently empty let's add private key for inita from config.ini:"
exe eosioc wallet import 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3 # from inita in config file

pause

color_printf "Using Pre-created keys for the accounts: from 'eosioc create key' (run twice)"

ownerPrivateKey="5JiwQXtj9SrUQEALMdweMLT1oSmLTvNRkaAZsz4g6syFTrNmgy6"
ownerPublicKey="EOS8Jv8qnHeCGuWusn6uoeGaq9y4dVaEf2nKLoNUNCEgWRe8HoLns"

activePrivateKey="5JofmFbasFYTg31kC59WVUV8GzDckaxA6F9qAKKeKtP6EZL6Hdm"
activePublicKey="EOS7UJ3nT6fboQdNgvnAA9Qihrr5A1VHeSdg5NejzTzRVip7tU4sc"


exe eosioc create account eosio ${ACCOUNT_NAME} $ownerPublicKey $activePublicKey

color_printf "Check that the account does now exist on the chain"
exe eosioc get account ${ACCOUNT_NAME}

pause

color_printf "import the private key for the new account which matches the above 'active' public key so we can set the code"
exe eosioc wallet import $activePrivateKey
