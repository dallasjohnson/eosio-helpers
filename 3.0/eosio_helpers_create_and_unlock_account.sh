#!/bin/bash

source "eosio_helpers_common"

if [[ ! $WALLET_PASSWORD || ! $ACCOUNT_NAME || ! $OWNER_PRIVATE_KEY || ! $ACTIVE_PRIVATE_KEY || ! $OWNER_PUBLIC_KEY || ! $ACTIVE_PUBLIC_KEY ]]; then
  echo '$WALLET_PASSWORD, $ACCOUNT_NAME, $OWNER_PRIVATE_KEY, $OWNER_PUBLIC_KEY, $ACTIVE_PUBLIC_KEY and $ACTIVE_PRIVATE_KEY ENV vars are not set.'
  exit 1;
fi

source eosio_helpers_unlock_wallet.sh

color_printf "Using Pre-created keys for the accounts: from 'cleos create key' (run twice)"

color_printf "import the keys into the wallet."
# exe cleos wallet import $OWNER_PRIVATE_KEY # Generally not needed for development
exe cleos wallet import $ACTIVE_PRIVATE_KEY

color_printf "List the current keys in the wallet:"
exe cleos wallet keys

exe cleos create account eosio ${ACCOUNT_NAME} $OWNER_PUBLIC_KEY $ACTIVE_PUBLIC_KEY

color_printf "Check that the account does now exist on the chain"
exe cleos get account ${ACCOUNT_NAME}
