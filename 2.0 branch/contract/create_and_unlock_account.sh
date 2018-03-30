#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/../../dev_helper_scripts/common.sh

ACCOUNT_NAME="simpledb"

color_printf "Unlock the default wallet: "

exe eosc wallet unlock --password PW5KEpcjL7vMc6ZjHLz2ymS9K6RMqJtEB55zgegZGSvk2XPx9gcc7 # password from creating a wallet using `eosioc wallet create`
color_printf "List the current keys:"
exe eosc wallet keys

color_printf "If it's currently empty let's add private key for inita from config.ini:"
exe eosc wallet import 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3 # from inita in config file

color_printf "Using Pre-created keys for the accounts: from 'eosioc create key' (run twice)"

ownerPrivateKey="5KXmeccz74ZWK2RDFoDYyJcfJz8AMJPZEYHE5x18rjWsJd71nFp"
ownerPublicKey="EOS5hSTw7kfYVrXu7NqzQvEGkUASHb5hy9GwcThjfbx9qd12thJzJ"

activePrivateKey="5JJy8uN4eaaaWiMnxhFMDi5jNQdN4QMLbgZKhcwkbqV8vAA7PX1"
activePublicKey="EOS65VhPhbW2MZUGKKfUG3myuXqrQo6WzAXBuiBRaynFTWgcVYRn9"

exe eosc create account inita ${ACCOUNT_NAME} $ownerPublicKey $activePublicKey

color_printf "Check that the account does now exist on the chain"
exe eosc get account ${ACCOUNT_NAME}

color_printf "import the private key for the new account which matches the above 'active' public key so we can set the code"
exe eosc wallet import $activePrivateKey
