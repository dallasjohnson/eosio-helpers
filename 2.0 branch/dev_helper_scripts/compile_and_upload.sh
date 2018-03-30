#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/common.sh

if [[ $# -lt 2 ]]; then
  color_printf "Error expected arguments\nUsage: $0 CONTRACT_NAME ACCOUNT_NAME"
  exit 1
fi

CONTRACT_NAME=$1
ACCOUNT_NAME=$2

color_printf "Set the code for a very basic contract again with permissions in our wallet."
CONTRACT_DIR="$EOSROOTPATH/contracts/$CONTRACT_NAME"

exe eoscpp -g $CONTRACT_DIR/$CONTRACT_NAME.abi $CONTRACT_DIR/$CONTRACT_NAME.hpp
exe eoscpp -o $CONTRACT_DIR/$CONTRACT_NAME.wast $CONTRACT_DIR/$CONTRACT_NAME.cpp
exe eosc set contract ${ACCOUNT_NAME} $CONTRACT_DIR/$CONTRACT_NAME.wast $CONTRACT_DIR/$CONTRACT_NAME.abi

pause

exe eosc push action ${ACCOUNT_NAME} issue '{"to":"inita", "quantity" : "100000.0 GBT", "memo" : "stimulate economy"}' -p "perm.explm@active"

