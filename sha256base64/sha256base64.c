/* sha256base64
 * Copyright 2013 Hal Canary
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you
 * may not use this file except in compliance with the License.  You
 * may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied.  See the License for the specific language governing
 * permissions and limitations under the License.
 */
#include <string.h>
#include <stdio.h>
#include <openssl/bio.h>
#include <openssl/evp.h>
#include <openssl/sha.h>

#define BUFFERSIZE 4096
void sha256base64(FILE * infile, FILE * out)
{
  unsigned char hash[SHA256_DIGEST_LENGTH];
  SHA256_CTX sha256;
  size_t read;
  char buffer[BUFFERSIZE];
  BIO *bio, *b64;
  SHA256_Init(&sha256);
  do {
    read = fread(buffer, 1, BUFFERSIZE, infile);
    SHA256_Update(&sha256, buffer, read);
  } while (read > 0);
  SHA256_Final(hash, &sha256);
  b64 = BIO_new(BIO_f_base64());
  bio = BIO_new_fp(out, BIO_NOCLOSE);
  bio = BIO_push(b64, bio);
  BIO_write(bio, hash, SHA256_DIGEST_LENGTH);
  BIO_flush(bio);
  BIO_free_all(bio);
  bio = NULL;
  b64 = NULL;
}

int main(int argc, char ** argv) {
	int i;
  if (argc < 2) {
    sha256base64(stdin, stdout);
    return EXIT_SUCCESS;
  }
  for (i = 1; i < argc; ++i) {
    if (strcmp(argv[i],"-") == 0) {
      sha256base64(stdin, stdout);
    } else {
      FILE * file = fopen(argv[i],"rb");
      sha256base64(file, stdout);
      fclose(file);
    }
  }
  return EXIT_SUCCESS;
}
