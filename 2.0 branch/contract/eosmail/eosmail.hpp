/**
 *  @file
 *  @copyright defined in eos/LICENSE.txt
 */
#include <eoslib/eos.hpp>
#include <eoslib/db.hpp>
#include <eoslib/string.hpp>

/* @abi action sendmail
*/
struct sendmail {
    account_name sender;
    account_name receiver;
    eosio::string messageData;
    uint64_t threadId;
};

/*
 * @abi table
*/
struct mail {
    account_name sender;
    account_name receiver;
    eosio::string messageData;
    uint64_t mailId;
    uint64_t threadId;
    uint8_t status; // unread, pending, rejected, approved

    mail(){};
    mail(const sendmail& s) {
     mailId = 12345;
     threadId = 54321;
     status = 1;
     sender = s.sender;
     receiver = s.receiver;
     messageData = s.messageData;
    }
};

   using mailstore = eosio::table<N(eosmail),N(eosmail),N(mail),mail,account_name>;

/* @abi action read
*/
struct read_email {
    uint64_t mailId;
    eosio::string messageData;
    uint8_t status; // unread, pending, rejected, approved
};

/* @abi action reply
*/
struct reply: mail { };