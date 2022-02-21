CYREN_INSTALL_HEADERS(ecdh.h PREFIX openssl)
CYREN_INSTALL_HEADERS(ech_locl.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    ech_lib.c
    ech_ossl.c
    ech_key.c
    ech_err.c
    ech_kdf.c
    PARENT_SCOPE)

OPENSSL_ADD_CRYPTO_TESTS(
    ecdhtest.c
    PARENT_SCOPE)
