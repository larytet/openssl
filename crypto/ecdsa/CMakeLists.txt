CYREN_INSTALL_HEADERS(ecdsa.h PREFIX openssl)
CYREN_INSTALL_HEADERS(ecs_locl.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    ecs_lib.c
    ecs_asn1.c
    ecs_ossl.c
    ecs_sign.c
    ecs_vrf.c
    ecs_err.c
    PARENT_SCOPE)

IF(EXPENSIVE_TESTS)
    OPENSSL_ADD_CRYPTO_TESTS(
        ecdsatest.c
        PARENT_SCOPE)
ENDIF()
