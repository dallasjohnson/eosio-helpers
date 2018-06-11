#!/bin/bash

source "eosio_helpers_common"

if [[ ! $WALLET_PASSWORD ]]; then
  echo '$WALLET_PASSWORD ENV var is not set.'
  exit 1;
fi

color_printf "Unlock the default wallet: "

exe cleos wallet unlock --password $WALLET_PASSWORD # password from creating a wallet using `cleos wallet create`
