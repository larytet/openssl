CYREN_INSTALL_HEADERS(seed.h PREFIX openssl)
CYREN_INSTALL_HEADERS(seed_locl.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    seed.c
    seed_ecb.c
    seed_cbc.c
    seed_cfb.c
    seed_ofb.c
    PARENT_SCOPE)
