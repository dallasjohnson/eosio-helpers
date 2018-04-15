# Eos.io-helper scripts
Simple scripts to help with eos.io contract development

This assumes you have your EOS.IO 3.0+ environment working and able to create blocks. It also assumes you have created a wallet (default wallet) and have the password available to unlock your wallet.

## Initial setup
First add the folder of scripts from this repo `eosio-helpers/3.0` to your path so all the contents are available from anywhere you try to execute them. They are all named with `eosio_helpers_` as a prefix to help easily find them with autocompletion (depending on your CLI of choice - I use Fish).

Add the password to unlock your default wallet into `eosio-helpers/3.0/eosio_helpers_common` so that it can be available for all contracts.

After creating a new contract either manually or using `eoscpp -n name` the development environment needs configuring so that you can stay focussed on the code for the contract rather that juggling command line tools, arguments, keys and other details.
The following scripts are intended to help simplify the set-up and aid context switching between code contracts or other day-time projects such as fiat-mining. The intention is to put as much configuration supporting the code contracts into code itself in the form of Bash scripts so that you can easily return to the code and continue where you left off.

For the below scripts no CLI arguments are required since all the variables are generated or captured from the current contract folder. 
Each command within the scripts is run with a command wrapper of `exe` to echo the command and the result to the console or `exef` which is the same but will terminate the remaining of the script if the command returns an error. eg. compilation error. Have a look in `eosio_helpers_common` for details.

Run through the following for each new code contract.

### 1. `eosio_helpers_seed_scripts.sh`
After creating a new contract folder run this from within the contract folder to create a file (`contract_vars`) to hold the needed variables for the below scripts to run. This will create the owner and active keys and add variables for the account name and the contract name which will be sourced by subsequent `cleos` commands in the below scripts. It will also copy any sample scripts from the `sample_scripts` folder (current example is based on the `currency` contract) which should be edited for each contract to exercise it's possible actions, similar to a TDD (Test driven development) style of working. This only needs running once to set up each new contract.

### 2. `eosio_helpers_create_and_unlock_account.sh`
Based on the keys and Account name vars from the step above, this script will add the keys to the default wallet and create the account for the contract on the local test chain. It's OK to run this multiple times since wallet will not add the same keys multiple times and the block chain will not create multiple accounts with the same name. If you have reset your local chain this could be run again to set up the account and code on a new chain.

### 3. `eosio_helpers_compile_and_upload.sh`
This will generate the ABI if the `SHOULD_GENERATE_ABI=true` in the `contract_vars` file. Then it will compile the  `$CONTRACT_NAME.cpp` file to wast and set the result on the local blockchain with the abi file using the credentials in the default wallet as set from step 2.

### 4. `./run.sh`
Assuming the above steps work then running this script would excercise the code paths of your contract so that you don't rely on your memory or shell history during development.
