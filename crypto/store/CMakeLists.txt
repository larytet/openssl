IF(OPENSSL_ENABLE_STORE)
    CYREN_INSTALL_HEADERS(store.h PREFIX openssl)
    CYREN_INSTALL_HEADERS(str_locl.h INTERNAL)

    OPENSSL_ADD_CRYPTO_SOURCES(
        str_err.c
        str_lib.c
        str_meth.c
        str_mem.c
        PARENT_SCOPE)
ENDIF()
