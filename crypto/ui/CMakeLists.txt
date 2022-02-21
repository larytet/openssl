CYREN_INSTALL_HEADERS(ui.h ui_compat.h PREFIX openssl)
CYREN_INSTALL_HEADERS(ui_locl.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    ui_err.c
    ui_lib.c
    ui_openssl.c
    ui_util.c
    ui_compat.c
    PARENT_SCOPE)
