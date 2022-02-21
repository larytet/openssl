CYREN_INSTALL_HEADERS(rc2.h PREFIX openssl)
CYREN_INSTALL_HEADERS(rc2_locl.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    rc2_ecb.c
    rc2_skey.c
    rc2_cbc.c
    rc2cfb64.c
    rc2ofb64.c
    PARENT_SCOPE)

OPENSSL_ADD_CRYPTO_TESTS(
    rc2test.c
    PARENT_SCOPE)
