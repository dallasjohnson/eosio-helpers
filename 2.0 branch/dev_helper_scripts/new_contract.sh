#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/common.sh

if [[ $# -lt 1 ]]; then
  color_printf "Error expected arguments\nUsage: $0 CONTRACT_NAME"
  exit 1
fi

CONTRACT_NAME=$1

color_printf "Creating a new smart contract named $CONTRACT_NAME"
pushd ../contracts/
exe eoscpp -n $CONTRACT_NAME
popd
