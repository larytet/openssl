IF(OPENSSL_ENABLE_JPAKE)
    CYREN_INSTALL_HEADERS(jpake.h PREFIX openssl)

    OPENSSL_ADD_CRYPTO_SOURCES(
        jpake.c
        jpake_err.c
        PARENT_SCOPE)

    OPENSSL_ADD_CRYPTO_TESTS(
        jpaketest.c
        PARENT_SCOPE)
ENDIF()
