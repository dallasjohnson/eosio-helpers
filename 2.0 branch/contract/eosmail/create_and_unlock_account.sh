#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/../../dev_helper_scripts/common.sh

ACCOUNT_NAME="eosmail"

color_printf "Unlock the default wallet: "

exe eosc wallet unlock --password PW5KEpcjL7vMc6ZjHLz2ymS9K6RMqJtEB55zgegZGSvk2XPx9gcc7 # password from creating a wallet using `eosioc wallet create`
color_printf "List the current keys:"
exe eosc wallet keys

color_printf "If it's currently empty let's add private key for inita from config.ini:"
exe eosc wallet import 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3 # from inita in config file

color_printf "Using Pre-created keys for the accounts: from 'eosioc create key' (run twice)"

ownerPrivateKey="5JkTAmzqW5Ys1uVTSnJmDbFxSYscVpXcYsn63J753Vvk7cDorY8"
ownerPublicKey="EOS4yGPtynLzApFTbns3dKvrxWPh126TYwQGNaAYarD2zATcNCNvB"

activePrivateKey="5JBeWP7XcTeHe8h98s2PBbG8NGtDZbep6S3tuH8LKus9QCMYmEN"
activePublicKey="EOS6VzNQRyRztuuoDebT95x3ceHpPyFC3miayzPfsm4tCwPvLeSw7"

exe eosc create account inita ${ACCOUNT_NAME} $ownerPublicKey $activePublicKey

color_printf "Check that the account does now exist on the chain"
exe eosc get account ${ACCOUNT_NAME}

color_printf "import the private key for the new account which matches the above 'active' public key so we can set the code"
exe eosc wallet import $activePrivateKey
