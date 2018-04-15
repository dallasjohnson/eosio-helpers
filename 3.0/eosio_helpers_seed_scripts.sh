#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -f contract_vars ]; then
    echo 'Seeded scripts "contract_vars" and "run.sh" already exist in the current directory.'
    echo '... Exiting with no change ...'
    exit 1
fi

cp $DIR/sample_scripts/* .
ownerkeys=(`cleos create key | awk '{ printf "%s\n", $3 }'`)
activekeys=(`cleos create key | awk '{ printf "%s\n", $3 }'`)

echo "" >> contract_vars
echo "OWNER_PRIVATE_KEY='${ownerkeys[0]}'" >> contract_vars
echo "OWNER_PUBLIC_KEY='${ownerkeys[1]}'" >> contract_vars
echo "" >> contract_vars
echo "ACTIVE_PRIVATE_KEY='${activekeys[0]}'" >> contract_vars
echo "ACTIVE_PUBLIC_KEY='${activekeys[1]}'" >> contract_vars
echo "" >> contract_vars
echo "CONTRACT_NAME=`basename $PWD`" >> contract_vars
echo "ACCOUNT_NAME=`basename $PWD`" >> contract_vars
echo "" >> contract_vars
echo "# Set to false if the ABI is from another source eg. super implementation as is currency." >> contract_vars
echo "SHOULD_GENERATE_ABI=true" >> contract_vars

echo 'Created "contract_vars" and "run.sh" in the current directory.'