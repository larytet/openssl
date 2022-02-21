IF(OPENSSL_ENABLE_MD2)
    CYREN_INSTALL_HEADERS(md2.h PREFIX openssl)

    OPENSSL_ADD_CRYPTO_SOURCES(
        md2_dgst.c
        md2_one.c
        PARENT_SCOPE)

    OPENSSL_ADD_CRYPTO_TESTS(
        md2test.c
        PARENT_SCOPE)
ENDIF()
