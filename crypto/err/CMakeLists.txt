CYREN_INSTALL_HEADERS(err.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    err.c
    err_all.c
    err_prn.c
    PARENT_SCOPE)
