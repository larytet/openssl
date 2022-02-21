CYREN_INSTALL_HEADERS(idea.h PREFIX openssl)
CYREN_INSTALL_HEADERS(idea_lcl.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    i_cbc.c
    i_cfb64.c
    i_ofb64.c
    i_ecb.c
    i_skey.c
    PARENT_SCOPE)

OPENSSL_ADD_CRYPTO_TESTS(
    ideatest.c
    PARENT_SCOPE)
