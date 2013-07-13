// compile with "-lcrypto"
#include <cstdlib> // free
#include <iostream> // cout
#include <exception> // exception
#include <openssl/bn.h> // BIGNUM
#include "Pointer.h" // Pointer

/**
   Convert a long hexidecimal number to decimal. */
int main(int, char **) {
  const char hexnumber[]
    = "b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9";
  Pointer< BIGNUM > bn(NULL, BN_clear_free);
  if (! BN_hex2bn(& bn,hexnumber))
    throw std::exception();
  Pointer< char > dec(BN_bn2dec(bn), free);
  std::cout << dec << '\n';
  return 0;
}
