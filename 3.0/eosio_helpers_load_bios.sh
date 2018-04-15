#!/bin/bash

source "eosio_helpers_common"

EOSROOTPATH="$HOME/Documents/Code/Eos/eosdawn3"

color_printf "Load the bios contract on the blockchain: \n This contract enables you to have direct control over the resource allocation of other accounts and to access other privileged API calls."
exe eosiocpp -o $EOSROOTPATH/contracts/eosio.bios/eosio.bios.wast $EOSROOTPATH/contracts/eosio.bios/eosio.bios.cpp
exe cleos set contract eosio $EOSROOTPATH/contracts/eosio.bios -p eosio