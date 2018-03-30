#pragma once
#include <eoslib/types.hpp>
#include <eoslib/message.hpp>
#include <eoslib/datastream.hpp>
#include <eoslib/raw_fwd.hpp>

namespace eosio { namespace raw {
   template<typename Stream> inline void pack( Stream& s, const sendmail& value ) {
      raw::pack(s, value.sender);
      raw::pack(s, value.receiver);
      raw::pack(s, value.messageData);
      raw::pack(s, value.threadId);
   }
   template<typename Stream> inline void unpack( Stream& s, sendmail& value ) {
      raw::unpack(s, value.sender);
      raw::unpack(s, value.receiver);
      raw::unpack(s, value.messageData);
      raw::unpack(s, value.threadId);
   }
   template<typename Stream> inline void pack( Stream& s, const mail& value ) {
      raw::pack(s, value.sender);
      raw::pack(s, value.receiver);
      raw::pack(s, value.messageData);
      raw::pack(s, value.mailId);
      raw::pack(s, value.threadId);
      raw::pack(s, value.status);
   }
   template<typename Stream> inline void unpack( Stream& s, mail& value ) {
      raw::unpack(s, value.sender);
      raw::unpack(s, value.receiver);
      raw::unpack(s, value.messageData);
      raw::unpack(s, value.mailId);
      raw::unpack(s, value.threadId);
      raw::unpack(s, value.status);
   }
   template<typename Stream> inline void pack( Stream& s, const read_email& value ) {
      raw::pack(s, value.mailId);
      raw::pack(s, value.messageData);
      raw::pack(s, value.status);
   }
   template<typename Stream> inline void unpack( Stream& s, read_email& value ) {
      raw::unpack(s, value.mailId);
      raw::unpack(s, value.messageData);
      raw::unpack(s, value.status);
   }
   template<typename Stream> inline void pack( Stream& s, const reply& value ) {
      raw::pack(s, static_cast<const mail&>(value));
   }
   template<typename Stream> inline void unpack( Stream& s, reply& value ) {
      raw::unpack(s, static_cast<mail&>(value));
   }
} }

#include <eoslib/raw.hpp>
namespace eosio {
   void print_ident(int n){while(n-->0){print("  ");}};
   template<typename Type>
   Type current_message_ex() {
      uint32_t size = message_size();
      char* data = (char *)eosio::malloc(size);
      assert(data && read_message(data, size) == size, "error reading message");
      Type value;
      eosio::raw::unpack(data, size, value);
      eosio::free(data);
      return value;
   }
   void dump(const sendmail& value, int tab=0) {
      print_ident(tab);print("sender:[");printn(value.sender);print("]\n");
      print_ident(tab);print("receiver:[");printn(value.receiver);print("]\n");
      print_ident(tab);print("messageData:[");prints_l(value.messageData.get_data(), value.messageData.get_size());print("]\n");
      print_ident(tab);print("threadId:[");printi(uint64_t(value.threadId));print("]\n");
   }
   template<>
   sendmail current_message<sendmail>() {
      return current_message_ex<sendmail>();
   }
   void dump(const mail& value, int tab=0) {
      print_ident(tab);print("sender:[");printn(value.sender);print("]\n");
      print_ident(tab);print("receiver:[");printn(value.receiver);print("]\n");
      print_ident(tab);print("messageData:[");prints_l(value.messageData.get_data(), value.messageData.get_size());print("]\n");
      print_ident(tab);print("mailId:[");printi(uint64_t(value.mailId));print("]\n");
      print_ident(tab);print("threadId:[");printi(uint64_t(value.threadId));print("]\n");
      print_ident(tab);print("status:[");printi(uint64_t(value.status));print("]\n");
   }
   template<>
   mail current_message<mail>() {
      return current_message_ex<mail>();
   }
   void dump(const read_email& value, int tab=0) {
      print_ident(tab);print("mailId:[");printi(uint64_t(value.mailId));print("]\n");
      print_ident(tab);print("messageData:[");prints_l(value.messageData.get_data(), value.messageData.get_size());print("]\n");
      print_ident(tab);print("status:[");printi(uint64_t(value.status));print("]\n");
   }
   template<>
   read_email current_message<read_email>() {
      return current_message_ex<read_email>();
   }
   void dump(const reply& value, int tab=0) {
   }
   template<>
   reply current_message<reply>() {
      return current_message_ex<reply>();
   }
} //eosio

