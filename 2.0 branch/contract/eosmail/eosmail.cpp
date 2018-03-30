/**
 *  @file
 *  @copyright defined in eos/LICENSE.txt
 */
#include <eosmail.hpp>
#include <eosmail.gen.hpp>

namespace eosmail {

    void apply_sendmail(const sendmail& mailPayload) {
        eosio::print("found mail: ", mailPayload.messageData,"\n");
        eosio::dump(mailPayload);
        auto mailToStore = mail(mailPayload);
        eosio::print("parsing to mail from sendMail:::");
        eosio::dump(mailToStore);

        auto bytes = eosio::raw::pack(mailPayload);
        // store_i64i64i64( N(eosmail), N(mail), bytes.data, bytes.len);
        bool result = mailstore::store(mailToStore);
        if (result){
            eosio::print("stored - - - :");
        } else {
            eosio::print("failed - - - :");
        }

    }
} // namespace eosmail

extern "C" {
    void init()  {
       eosio::print( "Init EOS MAIL \n" );
       eosio::print( "Email that doesn't get lost... in the mail. \n" );
    }

    /// The apply method implements the dispatch of events to this contract
    void apply( uint64_t code, uint64_t action ) {
       eosio::print( "Hello World: ", eosio::name(code), "->", eosio::name(action), "\n" );
        if(code == N(eosmail)) {
            if(action == N(sendmail)) {
                eosio::print("sending eosmail \n\n");
                eosmail::apply_sendmail(eosio::current_message<sendmail>());
            } else if(code == N(read)) {
                eosio::print(" reading eosmail ");
            } else if(code == N(reply)) {
                eosio::print(" replying to eosmail ");
            }
        }
    }

} // extern "C"
