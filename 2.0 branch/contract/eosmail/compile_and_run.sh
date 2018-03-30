#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/../../dev_helper_scripts/common.sh

CONTRACT_NAME=eosmail
ACCOUNT_NAME=eosmail

CONTRACT_DIR="$EOSROOTPATH/contracts/$CONTRACT_NAME"

color_printf "Generate the ABI based on the hpp"
exe eoscpp -g $CONTRACT_NAME.abi -gs $CONTRACT_NAME.hpp


color_printf "Compile the cpp and output to wast"
exe eoscpp -o $CONTRACT_NAME.wast $CONTRACT_NAME.cpp

color_printf "Set the code on the contract - must have keys unlocked with the account"
exe eosc set contract ${ACCOUNT_NAME} $CONTRACT_NAME.wast $CONTRACT_NAME.abi


color_printf "Test drive..."

color_printf "send a mail"
exe eosc push message ${ACCOUNT_NAME} sendmail '{"sender":"eosmail", "threadId":"98798343", "receiver": "lkjsdflkjf", "messageData":"lkjsldkjsldfkjljfjlksjksffdd" }' -S ${ACCOUNT_NAME}
color_printf "Read it back"
exe eosc get table ${ACCOUNT_NAME} ${ACCOUNT_NAME} mail

# color_printf "insert key value 2"
# exe eosc push message ${ACCOUNT_NAME} insertkv2 '{"key":"firstKey1", "value": {"name": "David", "age": "106" } }' -S ${ACCOUNT_NAME}
# color_printf "Read it back"
# exe eosc get table ${ACCOUNT_NAME} ${ACCOUNT_NAME} keyvalue2

# "u256":256, "u128":128, "u64":"64", "u32":32, "u16":16, "u8":8, "i64":-64, "i32":-32, "i16":-16, "i8":-8, "price":"12"
# color_printf "insert record 1"
# exe eosc push message ${ACCOUNT_NAME} insert1 '{"key":"1235", "u256":"258", "u128":"131", "u64":65, "u32":32, "u16":16, "u8":8, "i64":-64, "i32":-32, "i16":-16, "i8":-8 }' -S ${ACCOUNT_NAME}
# color_printf "Read it back"
# exe eosc get table ${ACCOUNT_NAME} ${ACCOUNT_NAME} record1

# color_printf "insert simple record"
# exe eosc push message ${ACCOUNT_NAME} insert2 '{"key1" : "7501", "key2" : "4051"}' -S ${ACCOUNT_NAME}
# color_printf "Read it back"
# exe eosc get table ${ACCOUNT_NAME} ${ACCOUNT_NAME} record2

# color_printf "insert record 3"
# exe eosc push message ${ACCOUNT_NAME} insert3 '{"key1":"7891", "key2":"464", "key3":"999", "value": {"name": "DallaS", "age": "101" }}' -S ${ACCOUNT_NAME}
# color_printf "Read it back"
# exe eosc get table ${ACCOUNT_NAME} ${ACCOUNT_NAME} record3
