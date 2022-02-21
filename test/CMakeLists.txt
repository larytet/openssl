CYREN_INSTALL_HEADERS(
    testutil.h
    ssltestlib.h
    INTERNAL)

OPENSSL_ADD_TESTS_FOR(crypto
    asn1test.c
    dummytest.c
    igetest.c)
