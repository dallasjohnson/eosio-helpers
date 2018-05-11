#!/bin/bash

token="EDB"

color_printf "Create a new currency"
exe cleos push action ${CONTRACT_NAME} create '{ "issuer": "'${ACCOUNT_NAME}'", "maximum_supply": "10000.0000 '${token}'", "can_freeze": 0, "can_recall": 0, "can_whitelist": 0}' -p ${ACCOUNT_NAME}

color_printf "Issue some to new currency"
exef cleos push action ${CONTRACT_NAME} issue '{ "to": "'${ACCOUNT_NAME}'", "quantity": "1000.0000 '${token}'", "memo": "Initial amount of tokens for you."}' -p ${ACCOUNT_NAME}

color_printf "Issue too much new currency - should fail"
exe cleos push action ${CONTRACT_NAME} issue '{ "to": "'${ACCOUNT_NAME}'", "quantity": "11000.0000 '${token}'", "memo": "Initial amount of tokens for you."}' -p ${ACCOUNT_NAME}

color_printf "Read back the stats"
exe cleos get currency stats ${CONTRACT_NAME} ${token}

color_printf "Transfer some tokens - should succeed"
exef cleos push action ${CONTRACT_NAME} transfer '{ "from": "'${ACCOUNT_NAME}'", "to": "eosio", "quantity": "500.0000 '${token}'", "memo": "my first transfer"}' --permission ${ACCOUNT_NAME}@active

color_printf "Read back the result balance - should increase"
exef cleos get currency balance ${CONTRACT_NAME} ${ACCOUNT_NAME}
