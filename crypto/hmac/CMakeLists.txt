CYREN_INSTALL_HEADERS(hmac.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    hmac.c
    hm_ameth.c
    hm_pmeth.c
    PARENT_SCOPE)

OPENSSL_ADD_CRYPTO_TESTS(
    hmactest.c
    PARENT_SCOPE)
