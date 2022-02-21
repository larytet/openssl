CYREN_INSTALL_HEADERS(lhash.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    lhash.c
    lh_stats.c
    PARENT_SCOPE)
