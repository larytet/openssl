CYREN_INSTALL_HEADERS(cmac.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    cmac.c
    cm_ameth.c
    cm_pmeth.c
    PARENT_SCOPE)
