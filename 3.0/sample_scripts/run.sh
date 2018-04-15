#!/bin/bash

source eosio_helpers_common

color_printf "Create a new currency"
exe cleos push action ${ACCOUNT_NAME} create '{ "issuer": "'${ACCOUNT_NAME}'", "maximum_supply": "1000000000.0000 LND", "can_freeze": 0, "can_recall": 0, "can_whitelist": 0}' -p ${ACCOUNT_NAME}

color_printf "Issue some to new currency"
exef cleos push action ${ACCOUNT_NAME} issue '{ "to": "'${ACCOUNT_NAME}'", "quantity": "10000.0000 LND", "memo": "Initial amount of tokens for you."}' -p ${ACCOUNT_NAME}

color_printf "Read back the result"
exef cleos get table ${ACCOUNT_NAME} ${ACCOUNT_NAME} accounts

color_printf "Transfer some tokens"
exef cleos push action currency transfer '{ "from": "'${ACCOUNT_NAME}'", "to": "eosio", "quantity": "20.0000 LND", "memo": "my first transfer"}' --permission currency@active

color_printf "Read back the result for currency"
exef cleos get table ${ACCOUNT_NAME} ${ACCOUNT_NAME} accounts

color_printf "Read back the result for eosio"
exef cleos get table ${ACCOUNT_NAME} eosio accounts