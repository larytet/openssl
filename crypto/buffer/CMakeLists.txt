CYREN_INSTALL_HEADERS(buffer.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    buffer.c
    buf_str.c
    buf_err.c
    PARENT_SCOPE)
