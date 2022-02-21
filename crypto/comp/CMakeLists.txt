CYREN_INSTALL_HEADERS(comp.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    comp_lib.c
    comp_err.c
    c_rle.c
    c_zlib.c
    PARENT_SCOPE)
