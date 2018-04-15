#!/bin/bash

source "eosio_helpers_common"

if [[ ! $CONTRACT_NAME || ! $ACCOUNT_NAME ]]; then
  echo '$CONTRACT_NAME and $ACCOUNT_NAME ENV vars are not set.'
  exit 1;
fi

if $SHOULD_GENERATE_ABI; then
  color_printf "Generate the ABI based on the cpp"
  exef eosiocpp -g $CONTRACT_NAME.abi $CONTRACT_NAME.cpp
else
  color_printf "Skip generating the ABI based from the cpp"
fi

color_printf "Compile the cpp and output to wast"
exef eosiocpp -o $CONTRACT_NAME.wast $CONTRACT_NAME.cpp

color_printf "Set the code on the contract"
cd ..
exef cleos set contract ${ACCOUNT_NAME} $CONTRACT_NAME -p $ACCOUNT_NAME
cd $CONTRACT_NAME