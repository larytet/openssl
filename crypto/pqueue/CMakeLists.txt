CYREN_INSTALL_HEADERS(pqueue.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    pqueue.c
    PARENT_SCOPE)
