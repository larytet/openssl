IF(OPENSSL_ENABLE_RC5)
    CYREN_INSTALL_HEADERS(rc5.h PREFIX openssl)
    CYREN_INSTALL_HEADERS(rc5_locl.h INTERNAL)

    OPENSSL_ADD_CRYPTO_SOURCES(
        rc5_skey.c
        rc5_ecb.c
        rc5cfb64.c
        rc5ofb64.c
        PARENT_SCOPE)

    IF(CYREN_ARCH_IS_AMD64)
        OPENSSL_ADD_CRYPTO_SOURCES(
            rc5_enc.c
            PARENT_SCOPE)

    ELSEIF(CYREN_ARCH_IS_I386)
        OPENSSL_ADD_CRYPTO_SOURCES(
            asm/rc5-586.pl
            PARENT_SCOPE PERLASM)
    ENDIF()

    OPENSSL_ADD_CRYPTO_TESTS(
        rc5test.c
        PARENT_SCOPE)
ENDIF()
