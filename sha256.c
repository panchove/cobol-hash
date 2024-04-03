#include <stdio.h>
#include <string.h>
#include <openssl/sha.h>
#include <openssl/evp.h>

// Convert the binary representation of the SHA256 hash into a human-readable string format. 
// It does this by iterating over each byte of the hash and converting it into a two-character hexadecimal 
// representation using the snprintf function.
void sha256_hash_string (unsigned char hash[SHA256_DIGEST_LENGTH], char outputBuffer[65])
{
    for(int i = 0; i < SHA256_DIGEST_LENGTH; i++)
    {
        snprintf(outputBuffer + (i * 2), 3, "%02x", hash[i]);
    }
}
// Function to compute the SHA-256 hash of a string
void sha256_string(char *string, char outputBuffer[65])
{
    unsigned char hash[SHA256_DIGEST_LENGTH];

    SHA256_CTX sha256;
    SHA256_Init(&sha256);
    SHA256_Update(&sha256, string, strlen(string));
    SHA256_Final(hash, &sha256);

    sha256_hash_string(hash, outputBuffer);
}

// Function to compute the SHA-256 hash of a string and return an error code
int sha256_string_error(char *string, char outputBuffer[65])
{
    EVP_MD_CTX *mdctx;
    unsigned char hash[EVP_MAX_MD_SIZE];
    unsigned int lengthOfHash = 0;

    if((mdctx = EVP_MD_CTX_new()) == NULL)
        return 1;

    if(1 != EVP_DigestInit_ex(mdctx, EVP_sha256(), NULL))
        return 1;

    if(1 != EVP_DigestUpdate(mdctx, string, strlen(string)))
        return 1;

    if(1 != EVP_DigestFinal_ex(mdctx, hash, &lengthOfHash))
        return 1;

    EVP_MD_CTX_free(mdctx);

    sha256_hash_string(hash, outputBuffer);

    return 0;

}